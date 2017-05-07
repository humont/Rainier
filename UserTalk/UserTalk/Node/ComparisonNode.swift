//
//  ComparisonNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

final class ComparisonNode: CodeTreeNode {

	// Both sides always evaluated.

	let operation: CodeTreeOperation
	let textPosition: TextPosition
	let node1: CodeTreeNode
	let node2: CodeTreeNode

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition, _ node1: CodeTreeNode, _ node2: CodeTreeNode) {

		self.operation = operation
		self.textPosition = textPosition
		self.node1 = node1
		self.node2 = node2
	}

	func evaluate() throws -> Value {

		do {
			let val1 = evaluate(node1)
			let val2 = evaluate(node2)

			switch operation {

			case .equalsOp:
				return try val1.equals(val2)

			case .notEqualsOp:
				return try !(val1.equals(val2))

			case greaterThanOp:
				return try val1.greaterThan(val2)

			case lessThanOp:
				return try val1.lessThan(val2)

			case greaterThanEqualsOp:
				return try val1.greaterThanEqual(val2)

			case lessThanEqualsOp:
				return try val1.lessThanEqual(val2)

			case beginsWithOp:
				return try val1.beginsWith(val2)

			case containsOp:
				return try val1.contains(val2)

			default:
				throw LangError(.illegalTokenError, textPosition: textPosition)
			}
		}
		catch { throw error }
	}
}
