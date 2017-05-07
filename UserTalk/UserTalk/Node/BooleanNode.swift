//
//  BooleanNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

final class BooleanNode: CodeTreeNode {

	// Short-circuited. node2 evaluated only when needed.

	let operation: CodeTreeOperation
	let textPosition: TextPosition
	let node1: CodeTreeNode
	let node2: CodeTreeNode

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition, _ node1: CodeTreeNode, _ node2: CodeTreeNode) {

		precondition(operation == .orOrOp || operation == .andAndOp)
		
		self.operation = operation
		self.textPosition = textPosition
		self.node1 = node1
		self.node2 = node2
	}

	func evaluate() throws -> Value {

		do {
			let val1 = evaluate(node1).asBool()

			func val2IsTrue() throws -> Bool {
				return try node2.evaluate().asBool()
			}
			
			switch operation {

			case .orOrOp:

				if val1 {
					return true
				}
				return val2IsTrue()

			case .andAndOp:

				if !val1 {
					return false
				}
				return val2IsTrue()

			default:
				throw LangError(.illegalTokenError, textPosition: textPosition)
			}
		}
		catch { throw error }
	}
}
