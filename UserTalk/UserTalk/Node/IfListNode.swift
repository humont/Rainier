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
	let nodes: [IFElseNode]

	init(_ textPosition: TextPosition, _ nodes: [CodeTreeNode]) {

		self.textPosition = textPosition
		self.nodes = nodes
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		do {
			var isFirst = true

			for oneNode in nodes {

				if isFirst {
					precondition(oneNode.operation == .ifOp);
				}

				if try oneNode.evaluateCondition(stack) {
					return try oneNode.evaluate(stack, breakOperation)
				}

				isFirst = false
			}
		}
		catch { throw error }
	}
}
