//
//  FunctionNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/4/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class FunctionNode: CodeTreeNode {

	let operation: CodeTreeOperation = .functionOp
	let textPosition: TextPosition
	let name: String
	let paramHeader: [ParamHeaderNode]
	let blockNode: BlockNode
	
	init(_ textPosition: TextPosition, name: String, paramHeader: [ParamHeaderNode], blockNode: BlockNode) {

		self.textPosition = textPosition
		self.name = name
		self.paramHeader = paramHeader
		self.blockNode = blockNode
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		preconditionFailure("evaluate() should not be called on a Function Node.")
	}

	func call(_ stack: Stack, _ params: [ParamNode]) throw -> Value {

		if params.count > paramHeader.count {
			throw LangError(.tooManyParameters, textPosition: params[0].textPosition)
		}

		stack.push(self)

		// TODO

		stack.pop()
	}
}
