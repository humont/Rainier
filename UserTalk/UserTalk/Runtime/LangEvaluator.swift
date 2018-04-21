//
//  Lang.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/23/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

public class LangEvaluator {
	
	fileprivate var lineNumber = 0
	fileprivate var characterIndex = 0
	fileprivate var errorNode: CodeTreeNode?
	fileprivate var flreturn = false
	fileprivate var flbreak = false
	fileprivate var flcontinue = false
	
	public func runCode(codeTreeNode: CodeTreeNode, context: HashTable?) throws -> Value {
		
		guard let firstNode = codeTreeNode.param1 else {
			return false //TODO: empty script error, perhaps
		}
		
		do {
			return try evaluateList(firstNode)
		}
		catch { throw error }
	}
	
	public func evaluateList(_ codeTreeNode: CodeTreeNode) throws -> Value {
		
		var programCounter: CodeTreeNode? = codeTreeNode
		var val = emptyValue
		
		do {
			while true {
				
				if programCounter == nil {
					break
				}
				
				setErrorLine(programCounter!)
				
				// TODO: check if user killed script
				// TODO: check if debugger killed script
				
				val = try evaluateTree(programCounter!)
				
				if flbreak || flreturn || flcontinue {
					break
				}
				
				if let next = programCounter!.link {
					programCounter = next
				}
			}
		}
		catch let e as LangError {
			if let _ = e.lineNumber {
				throw e
			}
			else {
				throw langError(e.errorType)
			}
		}
		catch { throw error }
		
		return val
	}
	
	public func evaluateTree(_ node: CodeTreeNode) throws -> Value {
		
		let op = node.nodeType
		let ctParams = node.ctParams
		var val1 = emptyValue
		var val2 = emptyValue
		
		do {
			if ctParams > 0 && op.shouldEvaluateParam1 {
				
				val1 = try evaluateTree(node.param1!)
				if flreturn {
					return true
				}
			}
			
			if ctParams > 1 && op.shouldEvaluateParam2 {
				
				val2 = try evaluateTree(node.param2!)
				if flreturn {
					return true
				}
			}
			
			setErrorLine(node)
			
			switch op {
				
//			case noOp:
//				return true

			case .localOp:
				return addLocals(node)
				
			case .moduleOp:
				return addHandler(node)
				
			case .identifierOp, .bracketOp:
				return idvalue(node)
				
			case .dotOp:
				return dotValue(node)
				
			case .addressOfOp:
				return addressOfValue(node.param1!)
				
			case .dereferenceOp:
				return dereferenceValue(node.param1!)
				
			case .arrayOp:
				return arrayValue(node)
				
			case .constOp:
				return copyValue(node.value!)
				
			case .assignOp:
				if !assignValue(node.param1!, val2) {
					return false
				}
				if val2.valueType == .external || !needAssignmentResult(node) {
					return true
				}
				return copyValue(val2)
				
			case .functionOp:
				return functionValue(node.param1!, node.param2!)
				
			case .addOp:
				return try val1.add(val2)
				
			case .subtractOp:
				return try val1.subtract(val2)
				
			case .unaryOp:
				return try val1.unaryMinusValue()
				
			case .multiplyOp:
				return try val1.multiply(val2)
				
			case .divideOp:
				return try val1.divide(val2)
				
			case .addValueOp:
				return modifyAssignValue(node.param1!, val2, .addOp, needAssignmentResult(node))
				
			case .subtractValueOp:
				return modifyAssignValue(node.param1!, val2, .subtractOp, needAssignmentResult(node))
				
			case .multiplyValueOp:
				return modifyAssignValue(node.param1!, val2, .multiplyOp, needAssignmentResult(node))
				
			case .divideValueOp:
				return modifyAssignValue(node.param1!, val2, .divideOp, needAssignmentResult(node))
				
			case .modOp:
				return try val1.mod(val2)
				
			case .notOp:
				return try val1.not()
				
//			case equalsOp:
//				return try val1.equals(val2)
//				
//			case notEqualsOp:
//				return try !(val1.equals(val2))
//				
//			case greaterThanOp:
//				return try val1.greaterThan(val2)
//				
//			case lessThanOp:
//				return try val1.lessThan(val2)
//				
//			case greaterThanEqualsOp:
//				return try val1.greaterThanEqual(val2)
//				
//			case lessThanEqualsOp:
//				return try val1.lessThanEqual(val2)
//				
//			case beginsWithOp:
//				return try val1.beginsWith(val2)
//				
//			case containsOp:
//				return try val1.contains(val2)

//			case orOrOp:
//				return orOrValue(val1, node.param2!)
//				
//			case andAndOp:
//				return andAndValue(val1, node.param2!)

//			case breakOp:
//				flbreak = true
//				return true

//			case continueOp:
//				flcontinue = true
//				return true
//				
//			case withOp:
//				return evaluateWith(node)

//			case returnOp:
//				flreturn = true
//				if val1.valueType == .none {
//					return true
//				}
//				return val1

//			case bundleOp:
//				return try evaluateList(node.param1!)

//			case ifOp: //{
//				let fl = try val1.asBool()
//				if let ifNode = fl ? node.param2 : node.param3 {
//					return try evaluateList(ifNode)
//				}
//				else {
//					return true
//				}
//				//}

//			case caseOp:
//				return evaluateCase(node)

			case .loopOp:
				return evaluateLoop(node)
				
			case .fileLoopOp:
				return evaluateFileLoop(node)
				
			case .forLoopOp:
				return evaluateForLoop(node, val1, val2, 1)
				
			case .forDownLoopOp:
				return evaluateForLoop(node, val1, val2, -1)
				
			case .incrementPreOp:
				return try incrementValue(node.param1!, increment: true, pre: true)
				
			case .incrementPostOp:
				return try incrementValue(node.param1!, increment: true, pre: false)
				
			case .decrementPreOp:
				return try incrementValue(node.param1!, increment: false, pre: true)
				
			case .decrementPostOp:
				return try incrementValue(node.param1!, increment: false, pre: false)
				
//			case tryOp:
//				return evaluateTry(node)
				
			case .rangeOp:
				throw langError(.badRangeOperation)
				
			case .fieldOp:
				throw langError(.badFieldOperation)
				
			case .listOp:
				return makeList(node.param1!)
				
			case .recordOp:
				return makeRecord(node.param1!)
				
			case .forInLoopOp:
				return evaluateForInLoop(node, val1)
				
			default:
				break
			}
			
			throw langError(.unexpectedOpCode)
		}
			
		catch let e as LangError {
			if let _ = e.lineNumber {
				throw e
			}
			else {
				throw langError(e.errorType)
			}
		}
		catch {
			throw error
		}
	}
}

private extension LangEvaluator {
	
	func langError(_ errorType: LangError.LangErrorType) -> LangError {
		
		return LangError(errorType, lineNumber: lineNumber, characterIndex: characterIndex)
	}
	
	func setErrorLine(_ node: CodeTreeNode) {
		
		if let lineNumber = node.lineNumber {
			self.lineNumber = lineNumber
		}
		if let characterIndex = node.characterIndex {
			self.characterIndex = characterIndex
		}
		errorNode = node
	}
}

private extension LangEvaluator {
	
	func addLocals(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func addHandler(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func idvalue(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func dotValue(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func addressOfValue(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func dereferenceValue(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func arrayValue(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func copyValue(_ value: Value) -> Bool {
		
		return true
	}
	
	func assignValue(_ node: CodeTreeNode, _ value: Value) -> Bool {
		
		return true
	}
	
	func needAssignmentResult(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func functionValue(_ node: CodeTreeNode, _ node2: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func orOrValue(_ value: Value, _ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func andAndValue(_ value: Value, _ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func evaluateWith(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func evaluateCase(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func evaluateLoop(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func evaluateFileLoop(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func evaluateForLoop(_ node: CodeTreeNode, _ val1: Value, _ val2: Value, _ increment: Int) -> Value {
		
		return true
	}
	
	func incrementValue(_ node: CodeTreeNode, increment: Bool, pre: Bool) throws -> Value {
		
		return true
	}
	
	func evaluateTry(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func makeList(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func makeRecord(_ node: CodeTreeNode) -> Bool {
		
		return true
	}
	
	func evaluateForInLoop(_ node: CodeTreeNode, _ value: Value) -> Bool {
		
		return true
	}
	
	func modifyAssignValue(_ node: CodeTreeNode, _ value: Value, _ operation: CodeTreeNodeType, _ needResult: Bool) -> Bool {
		
		return true
	}
	
}

