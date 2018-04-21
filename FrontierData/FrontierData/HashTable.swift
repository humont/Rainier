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
	var name: String? //Maybe this is owned by parent instead?
	public var isReadOnly = false

	public init(_ name: String, _ parentHashTable: HashTable?) {

		self.parentHashTable = parentHashTable
		self.name = name

		parentHashTable?.add(name, self)
	}

	public func add(_ key: String, _ value: Any) {

		assert(!isReadOnly, "Can’t add to a read-only table.")
		guard !isReadOnly else {
			return
		}
		
		if let keyToUse = canonicalKeyForKey(key) {
			dictionary[keyToUse] = value // existing object
		}
		else {
			dictionary[key] = value // new object
		}
	}

	public func addTable(_ table: HashTable) {

		table.dictionary.forEach { (oneKey, oneValue) in
			add(oneKey, oneValue)
		}
	}

	public func lookup(_ key: String) -> Any? {

		if let keyToUse = canonicalKeyForKey(key) {
			return dictionary[keyToUse]
		}
		return nil
	}
	
	public func addressOf(_ key: String) -> Address? {
		
		if let _ = canonicalKeyForKey(key) {
			return Address(hashTable: self, name: key)
		}
		return nil
	}

	public subscript (_ key: String) -> Any? {
		get {
			return lookup(key)
		}
	}
}

private extension HashTable {
	
	func canonicalKeyForKey(_ key: String) -> String? {
		
		// Getting and setting is case insensitive, but the original case is saved: that’s the canonical key.
		
		if let _ = dictionary[key] {
			return key
		}
		let lowerKey = key.lowercased()
		for oneKey in dictionary.keys {
			if lowerKey == oneKey.lowercased() {
				return oneKey
			}
		}
		return nil
	}
}

