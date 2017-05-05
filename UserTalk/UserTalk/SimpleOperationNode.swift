//
//  File.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

final class SimpleOperationNode: CodeTreeNode {

	let operation: CodeTreeOperation
	let textPosition: TextPosition
	var prevlink: CodeTreeNode?
	var link: CodeTreeNode?

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition) {

		assert(operation == .breakOp || operation == .continueOp || operation == .noOp)
		self.operation = operation
	}
	
	func evaluate() throws -> Value {
		
		return false //TODO
	}
}
