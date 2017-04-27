//
//  ValueNone.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/22/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension NSNull: Value {
	
	public var valueType: ValueType {
		get {
			return .none
		}
	}
	
	func asBool() throws -> Bool {
		
		return false
	}
	
	func asChar() throws -> CChar {
		
		return CChar(0)
	}
	
	func asInt() throws -> Int {
		
		return 0
	}

	func asDouble() throws -> Double {
		
		return doubleAssumingIntValue()
	}

	func asDirection() throws -> Direction {
		
		do {
			return try directionAssumingIntValue()
		}
		catch { throw error }
	}
	
}
