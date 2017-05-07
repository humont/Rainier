//
//  BlockNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/4/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class BlockNode: CodeTreeNode {

	// A block of code — a list of statements.

	let operation: CodeTreeOperation = .blockOp
	let textPosition = TextPosition.start() // TextPosition of first statement in block is relevant
	let statements: [CodeTreeNode]

	init(_ statements: [CodeTreeNode]) {

		self.statements = statements
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		// Caller should have pushed a stack frame if needed.
		
		do {
			for oneNode in statements {

				let value = try oneNode.evaluate(breakOperation)

				if breakOperation == .returnOp {
					return value
				}
				if breakOperation == .breakOp || breakOperation == .continueOp {
					return true
				}
			}
		}
		catch { throw error }
	}
}
