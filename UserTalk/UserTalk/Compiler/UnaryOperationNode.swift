//
//  UnaryOperationNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

struct UnaryOperationNode {

	let operation: CodeTreeOperation
	let expressionNode: CodeTreeNode
	var link: CodeTreeNode?
	var prevlink = CodeTreeNode?

	init(_ operation: CodeTreeOperation, _ expressionNode: CodeTreeNode) {

		self.operation = operation
		self.expressionNode = expressionNode
	}
}
