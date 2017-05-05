//
//  BooleanNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

final class BooleanNode: CodeTreeNode {

	// Short-circuited. rhs evaluated only when needed.

	let operation: CodeTreeOperation
	let textPosition: TextPosition
	let lhs: CodeTreeNode
	let rhs: CodeTreeNode
	var link: CodeTreeNode?
	var prevlink: CodeTreeNode?

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition, _ lhs: CodeTreeNode, _ rhs: CodeTreeNode) {

		self.operation = operation
		self.lhs = lhs
		self.rhs = rhs
		self.textPosition = textPosition
	}

	func evaluate() throws -> Value {

		do {
			let leftValue = evaluate(lhs).asBool()

			func rightValueIsTrue() throws -> Bool {
				return try rhs.evaluate().asBool()
			}
			
			switch operation {

			case .orOrOp:

				if leftValue {
					return true
				}
				return rightValueIsTrue()

			case .andAndOp:

				if !leftValue {
					return false
				}
				return rightValueIsTrue()

			default:
				throw LangError(.illegalTokenError, textPosition: textPosition)
			}
		}
		catch { throw error }
	}
}
