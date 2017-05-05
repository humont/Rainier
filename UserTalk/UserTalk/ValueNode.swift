//
//  ValueNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/4/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class ValueNode: CodeTreeNode {
	
	let operation: CodeTreeOperation
	let textPosition: TextPosition
	let value: Value
	var link: CodeTreeNode?
	var prevlink: CodeTreeNode?
	
	init(_ operation: CodeTreeOperation, _ textPosition: textPosition, _ value: Value) {
	
		assert(operation == .constOp || operation == .identifierOp)
		
		self.operation = operation
		self.textPosition = textPosition
		self.value = value
	}
	
	func evaluate() throws -> EvaluateResult {
		
		return valueResult(value) // TODO
	}
}
