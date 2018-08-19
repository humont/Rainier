//
//  IfElseNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/6/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class IfElseNode: CodeTreeNode {

	let operation: CodeTreeOperation
	let textPosition: TextPosition
	let conditionNode: CodeTreeNode
	let blockNode: BlockNode

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition, _ conditionNode: CodeTreeNode, _ blockNode: BlockNode) {

		self.textPosition = textPosition
		self.nodes = nodes
	}

	func evaluateCondition(_ stack: Stack) throws -> Bool {

		do {
			var breakOperation: CodeTreeOperation = .noOp // break, return, continue should not be in conditions, so this can be ignored.
			return try conditionNode.evaluate(stack, &breakOperation).asBool()
		}
		catch { throw error }
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		stack.push(self)
		defer {
			stack.pop()
		}

		do {

			let value = try blockNode.evaluate(stack, breakOperation)
		}
		catch { throw error }
	}
}
