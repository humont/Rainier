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
	var withAddress: Address?

	init(_ node: CodeTreeNode, _ parent: StackFrame?) {

		self.locals = HashTable(name, parent.locals)
		self.name = name
		self.parent = parent
		self.withAddress = nil
	}

	func addLocals(_ localsToAdd: Hashtable) {

		locals.addTable(localsToAdd)
	}

	func addLocal(_ name: String, _ value: Value) {

		locals.add(name, value)
	}

	func lookup(_ key: String) -> Value? {

		// TODO: Handle withAddress when looking up a symbol.

		if let value = locals.lookup(key) as Value {
			return value
		}
		if node.operation != .moduleOp { // Don't search backwards past a script
			if let value = parent?.lookup(key) {
				return value
			}
		}

		return Evaluator.lookupGlobalValue(key, withAddress)
	}
}
