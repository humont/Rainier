//
//  ComparisonNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

struct ComparisonNode {

	// Both sides always evaluated.

	let operation: CodeTreeOperation
	let lhs: CodeTreeNode
	let rhs: CodeTreeNode
	let textPosition: TextPosition
	var link: CodeTreeNode?
	var prevlink: CodeTreeNode?

	init(_ operation: CodeTreeOperation, _ lhs: CodeTreeNode, _ rhs: CodeTreeNode, _ textPosition: TextPosition) {

		self.operation = operation
		self.lhs = lhs
		self.rhs = rhs
		self.textPosition = textPosition
	}

	func evaluate() throws -> Value {

		do {
			let val1 = evaluate(lhs)
			let val2 = evaluate(rhs)

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
