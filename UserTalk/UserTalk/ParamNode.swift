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
	let value: CodeTreeNode?
	
	init(_ textPosition: TextPosition, name: String, params: [Params], blockNode: BlockNode) {
		
	}
}
