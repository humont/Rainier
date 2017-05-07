//
//  FunctionCallNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/6/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class FunctionCallNode: CodeTreeNode {

	// a.b.c(foo, bar: 17, nerf:x.y.z())
	// a.b.c is the expressionNode
	// foo, bar, nerf is params

	let operation: CodeTreeOperation = .functionCallOp
	let textPosition: TextPosition
	let expressionNode: CodeTreeNode // Thing that evaluates to function address
	let params: [ParamNode]

	init(_ textPosition: TextPosition, _ expressionNode: CodeTreeNode, _ params: [ParamNode]) {

		self.textPosition = textPosition
		self.expressionNode = expressionNode
		self.params = params
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		do {
			let functionAddress = expressionNode.evaluate(stack, breakOperation)
			
		}
		catch { throw error }

	}

}
