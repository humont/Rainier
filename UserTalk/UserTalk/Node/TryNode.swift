//
//  TryNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// try // TryNode
//    some.thing() // BlockNode
// else // BlockNode
//    other.thing()

final class TryNode: CodeTreeNode {

	let operation = .bundleOp
	let textPosition: TextPosition
	let blockNode: BlockNode
	let elseNode: BlockNode?

	init(_ textPosition: TextPosition, _ blockNode: BlockNode, _ elseNode: BlockNode?) {

		self.textPosition = textPosition
		self.blockNode = blockNode
		self.elseNode = elseNode
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		do {
			stack.push(self)
			defer {
				stack.pop()
			}
			return try blockNode.evaluate(stack, &tempBreakOperation)
		}
		catch { }

		// There was an error.

		do {
			stack.push(self)
			defer {
				stack.pop()
			}

			breakOperation = .noOp // Possible that it was set above, so it should be reset
			try return blockNode.evaluate(stack, breakOperation)
		}
		catch { throw error }
	}
}
