//
//  Evaluator.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/6/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

public class Evaluator {

	var stack = Stack()
	let scriptNode: ScriptNode

	init(_ scriptNode: ScriptNode) {

		self.scriptNode = scriptNode
	}

	func evaluate() throws -> Value {

		var breakOperation = .noOp
		return scriptNode.evaluate(stack, &breakOperation)
	}
}
