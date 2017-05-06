//
//  ParamNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/5/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class FunctionHeaderParamNode: CodeTreeNode {
	
	// on (foo, bar, baz=3*9, nerf="well", dill=pick.le())
	
	let operation: CodeTreeOperation = .paramHeaderOp
	let textPosition: TextPosition
	let name: String?
	let defaultValueExpression: CodeTreeNode?
	
	init(_ textPosition: TextPosition, name: String, params: [Params], blockNode: BlockNode) {
		
	}
}
