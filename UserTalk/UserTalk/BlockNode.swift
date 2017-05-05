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
	var statements = [CodeTreeNode]()

	func push(_ node: CodeTreeNode) {

		statements += [node]
	}

	func evaluate(_ breakOperation: inout CodeTreeOperation) throws -> Value

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
