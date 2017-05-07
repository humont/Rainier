//
//  ScriptNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/4/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

final class ScriptNode: CodeTreeNode {

	// Top level of every script.

	let operation: CodeTreeOperation = .moduleOp
	let textPosition = TextPosition.start() // By definition
	let blockNode: BlockNode
	
	init(_ blockNode: BlockNode) {
		
		self.blockNode = blockNode
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		stack.push(self)
		var breakOperation = .noOp

		do {
			return try blockNode.evaluate(stack, &breakOperation)
		}
		catch { throw error }

		stack.pop()
	}
}
