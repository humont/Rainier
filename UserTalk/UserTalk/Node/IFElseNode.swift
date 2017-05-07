//
//  IFElseNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/6/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

func class IFElseNode: CodeTreeNode {

	let operation: CodeTreeOperation
	let textPosition: TextPosition
	let conditionNode: CodeTreeNode
	let blockNode: BlockNode

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition, _ conditionNode: CodeTreeNode, _ blockNode: BlockNode) {

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
