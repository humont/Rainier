//
//  ReturnNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

final class ReturnNode: CodeTreeNode {

	let operation: CodeTreeOperation = .returnOp
	let textPosition: TextPosition
	let expressionNode: CodeTreeNode?

	init(_ textPosition: TextPosition, _ expressionNode: CodeTreeNode?) {

		self.textPosition = textPosition
		self.expressionNode = expressionNode
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		breakOperation = .returnOp

		if let expressionNode = expressionNode {

			do {
				var ignoredBreakOperation: CodeTreeOperation = .noOp
				return try expressionNode.evaluate(stack, &ignoredBreakOperation)
			}
			catch { throw error }
		}

		return true
	}
}
