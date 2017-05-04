//
//  BooleanNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

struct BooleanNode {

	// rhs evaluated only when needed. Short-circuited.

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

	private func rhsIsTrue() throws -> Bool {

		return try rhs.evaluate().asBool()
	}

	func evaluate() throws -> Value {

		do {
			let val1 = evaluate(lhs).asBool()

			switch operation {

			case .orOrOp:

				if val1 {
					return true
				}
				return rhsIsTrue()

			case .andAndOp:

				if !val1 {
					return false
				}
				return rhsIsTrue()

			default:
				throw LangError(.illegalTokenError, textPosition: textPosition)
			}
		}
		catch { throw error }
	}
}
