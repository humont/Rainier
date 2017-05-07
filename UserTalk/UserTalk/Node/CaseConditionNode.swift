//
//  CaseConditionNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// case value // CaseNode
//	 x // CaseConditionNode
//      thing() // BlockNode


final class CaseConditionNode: CodeTreeNode {

	let operation = .caseItemOp
	let textPosition: TextPosition
	let conditionNode: CodeTreeNode
	let blockNode: BlockNode

	init(_ textPosition: TextPosition, _ conditionNode: CodeTreeNode, _ blockNode: BlockNode) {

		self.textPosition = textPosition
		self.conditionNode = conditionNode
		self.blockNode = blockNode
	}

	func evaluateCondition(_ stack: Stack) throws -> Value {

		do {
			var ignoredBreakOperation: CodeTreeOperation = .noOp
			return try condition.evaluate(stack, &breakOperation)
		}
		catch { throw error }
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		stack.push()
		defer {
			stack.pop()
		}

		do {
			try return blockNode.evaluate(stack, breakOperation)
		}
		catch { throw error }
	}
}
