//
//  File.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

struct SimpleOperationNode {

	let operation: CodeTreeOperation
	let textPosition: TextPosition
	var prevLink: CodeTreeNode?
	var link: CodeTreeNode?

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition) {

		assert(operation == .breakOp || operation == .continueOp || operation == .noOp)
		self.operation = operation
	}
}
