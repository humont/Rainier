//
//  UnaryOperationNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

final class UnaryOperationNode: CodeTreeNode {

	let operation: CodeTreeOperation
	let textPosition: TextPosition
	let expressionNode: CodeTreeNode

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition, _ expressionNode: CodeTreeNode) {

		self.operation = operation
		self.expressionNode = expressionNode
	}
	
	func evaluate() throws -> Value {
		
		return false // TODO
	}
}
