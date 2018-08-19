//
//  WithNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class WithNode: CodeTreeNode {

	let operation = .withOp
	let textPosition: TextPosition
	let expressionNode: CodeTreeNode // Evaluates to address
	let blockNode: BlockNode

	init(_ textPosition: TextPosition, _ expressionNode: CodeTreeNode, _ blockNode: BlockNode) {

		self.blockNode = blockNode
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		do {
			try withAddress = (try expressionNode.evaluate(stack, breakOperation)).asAddress()
		}
		catch { throw error }

		var stackFrame = stack.push(self)
		stackFrame.withAddress = withAddress
		defer {
			stack.pop()
		}

		do {
			try return blockNode.evaluate(stack, breakOperation)
		}
		catch { throw error }
	}
}
