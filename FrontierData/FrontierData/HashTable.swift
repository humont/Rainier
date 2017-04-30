//
//  HashTable.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/20/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

// See tyhashtable in lang.h in FrontierOrigFork.

public final class HashTable {
	
	var dictionary = [String: Any]()
	var parentHashTable: HashTable?
	var dirty = false
	var locked = false
	var isLocalTable = false
	var representedObject: Any?
	var dateCreated: Date?
	var name: String?
	public var isReadOnly = false

	public init(_ name: String, _ parentHashTable: HashTable?) {

		self.parentHashTable = parentHashTable
		self.name = name

		parentHashTable?.add(name, self)
	}

	public func add(_ key: String, _ value: Any) {

		assert(!isReadOnly, "Can’t add to a read-only table.")
		if !isReadOnly {
			dictionary[key] = value
		}
	}

	public func lookup(_ key: String) -> Any? {

		return dictionary[key]
	}
}

