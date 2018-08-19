//
//  LoopNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// for (i = 0; i < 10; i++) // LoopNode
//   script() //BlockNode

final class LoopNode: CodeTreeNode {
	
	let operation: CodeTreeOperation = .loopOp
	let textPosition: textPosition
	let assignmentNode: AssignmentNode
	let conditionNode: ComparisonNode
	let incrementNode: CodeTreeNode
	let blockNode: BlockNode
	
	init(_ textPosition: TextPosition, _ assignmentNode: AssignmentNode, _ conditionNode: ComparisonNode, _ incrementNode: CodeTreeNode, _ blockNode: BlockNode) {
		
		self.textPosition = textPosition
		self.assignmentNode = assignmentNode
		self.conditionNode = conditionNode
		self.incrementNode = incrementNode
		self.blockNode = blockNode
	}
	
	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {
		
		var ignoredBreakOperation = .noOp
		do {
			let ix = try assignmentNode.evaluate(stack, &ignoredBreakOperation).asInt()
		}
		catch { throw error }
		
		while true {
			
			do {
				if !conditionNode.evaluate(stack, &ignoredBreakOperation) {
					break
				}
			}
			catch { throw error }
			
			var innerBreakOperation: CodeTreeOperation = .noOp
			stack.push(blockNode)
			defer {
				stack.pop()
			}
			
			do {
				try blockNode.evaluate(stack, &innerBreakOperation)
			}
			catch { throw error }
			
			if innerBreakOperation == .breakOp {
				break
			}
			if innerBreakOperation == .returnOp {
				breakOperation = .returnOp
				break
			}
			
			do {
				try incrementNode.evaluate(stack, &ignoredBreakOperation)
			}
			catch { throw error }
		}
		
		return ix
	}
}
