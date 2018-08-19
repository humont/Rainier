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

	// TODO: gather withAddress objects from stack into array
	// TODO: see if withAddress is checked before locals
	
	func addressOf(_ key: String) -> Address? {
		
		// Looks through locals, then looks at the database.
		
		if let address = locals.addressOf(key) {
			return address
		}
		
		if let parent = parent {
			if node.operation != .moduleOp { // Don't search backwards past a script
				if let address = parent.addressOf(key) {
					return address
				}
			}
		}
		
		return Evaluator.addressOf(key, withAddress)
	}
	
	func ensureAddress(_ key: String) -> Address? {
		
		// If it doesn’t exist, make it a local.
		// But! If it’s a keypath, and every part of the keypath except the name component points to a real thing, then use the address from the keypath.
		// And: If it’s a keypath, and some part of the keypath points to a real thing, but not all of it, then return nil.
		// If creating a new thing, give it an empty value.
		
		// TODO
		return nil
	}
	
	func defined(_ key: String) -> Bool {
		
		// If in locals, then it’s defined.
		// If in database, then it’s defined.
		
		// TODO
		
		return false
	}
	
 	func lookup(_ key: String) -> Value? {

		// TODO: Handle withAddress when looking up a symbol.

		if let value = locals.lookup(key) as Value {
			return value
		}
		if node.operation != .moduleOp { // Don't search backwards past a script
			if let value = parent?.lookupValue(key) {
				return value
			}
		}

		return Evaluator.lookupGlobalValue(key, withAddress)
	}
}
