//
//  StackFrame.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/6/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class StackFrame {

	var locals: HashTable
	let node: CodeTreeNode
	let parent: StackFrame?

	init(_ node: CodeTreeNode, _ parent: StackFrame?) {

		self.locals = HashTable(name, parent.locals)
		self.name = name
		self.parent = parent
	}

	func addLocals(_ localsToAdd: Hashtable) {

		locals.addTable(localsToAdd)
	}

	func addLocal(_ name: String, _ value: Value) {

		locals.add(name, value)
	}

	func lookup(_ key: String) -> Value? {

		if let value = locals.lookup(key) as Value {
			return value
		}
		if node.operation == .moduleOp {
			return nil // Don't search backwards past a script
		}
		if let parent = parent {
			return parent.lookup(key)
		}
		return nil
	}
}
