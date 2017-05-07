//
//  CaseNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// case value // CaseNode
//	 x // CaseConditionNode
//      thing()
//   y //CaseConditionNode
//      otherThing()
// else //elseNode (BlockNode)
//   defaultThing()
//

final class CaseNode: CodeTreeNode {

	let operation = .caseOp
	let textPosition: TextPosition
	let valueNode: CodeTreeNode
	let conditionNodes: [CaseConditionNode]
	let elseNode: BlockNode?

	init(_ textPosition: TextPosition, _ valueNode: [CodeTreeNode], _ conditionNodes: [CaseConditionNode], _ elseNode: BlockNode?) {

		self.blockNode = blockNode
		self.conditionNodes = conditionNodes
		self.elseNode = elseNode
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		do {
			var ignoredBreakOption: CodeTreeOperation = .noOp
			let valueToMatch = try valueNode.evaluate(stack, &ignoredBreakOption)

			for oneCondition in conditionNodes {
				let oneConditionValue = try oneCondition.evaluateCondition(stack)
				if oneConditionValue.equals(valueToMatch) {
					return try oneCondition.evaluate(stack, breakOperation)
				}
			}

			// All conditions failed
			if let elseNode = elseNode {
				stack.push()
				defer {
					stack.pop()
				}
				return try elseNode.evaluate(stack, breakOperation)
			}
		}
		catch { throw error }
	}
}
