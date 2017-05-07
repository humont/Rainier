//
//  IfListNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/6/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

// if something
// else if something else
// else if another thing
// else

func class IfListNode: CodeTreeNode {

	let operation: CodeTreeOperation = .ifListOp
	let textPosition: TextPosition
	let nodes: [IfElseNode]

	init(_ textPosition: TextPosition, _ nodes: [IfElseNode]) {

		self.textPosition = textPosition
		self.nodes = nodes
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		do {
			var isFirst = true
			var isLast = false
			var ix = 0

			for oneNode in nodes {

				isLast = (ix == nodes.count - 1)

				if isFirst {
					precondition(oneNode.operation == .ifOp)
				}
				else {
					precondition(oneNode.operation == .elseIfOp || oneNode.operation == .elseOp)
				}

				if isLast {
					if oneNode.operation == .elseOp {
						return try oneNode.evaluate(stack, breakOperation)
					}
				}

				if try oneNode.evaluateCondition(stack) {
					return try oneNode.evaluate(stack, breakOperation)
				}

				isFirst = false
				ix = ix + 1
			}
		}
		catch { throw error }
	}
}
