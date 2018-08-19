//
//  ParamHeaderNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/5/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class ParamHeaderNode: CodeTreeNode {
	
	// on (foo, bar, baz=3*9, nerf="well", dill=pick.le())
	
	let operation: CodeTreeOperation = .paramHeaderOp
	let textPosition: TextPosition
	let name: String?
	let defaultValueExpression: CodeTreeNode?
	
	init(_ textPosition: TextPosition, name: String, defaultValueExpression: CodeTreeNode?) {

		self.textPosition = textPosition
		self.name = name
		self.defaultValueExpression = defaultValueExpression
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

	}
}
