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
	var blockNode: BlockNode

	func evaluate(_ breakOperation: inout CodeTreeOperation) throws -> Value {

		do {
			var breakOperation = .noOp
			return try blockNode.evaluate(&breakOperation)
		}
		catch { throw error }
	}
}
