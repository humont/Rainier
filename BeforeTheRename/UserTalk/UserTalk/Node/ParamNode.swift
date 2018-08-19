//
//  ParamNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/5/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class ParamNode: CodeTreeNode {
	
	// do.a.script(foo, 7, baz:54, nerf:"deep", dill:weed())
	
	let operation: CodeTreeOperation = .paramOp
	let textPosition: TextPosition
	let name: String?
	let expression: CodeTreeNode?
	
	init(_ textPosition: TextPosition, _ name: String, _ expression: CodeTreeNode) {

		self.textPosition = textPosition
		self.name = name
		self.expression = expression
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		do {
			return try expression.evaluate(breakOperation)
		}
		catch { throw error }
	}
}
