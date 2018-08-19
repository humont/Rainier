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
			return .noValue
		}
	}
	
	public func asBool() throws -> Bool {
		
		return false
	}
	
	public func asChar() throws -> CChar {
		
		return CChar(0)
	}
	
	public func asInt() throws -> Int {
		
		return 0
	}

	public func asDouble() throws -> Double {
		
		return doubleAssumingIntValue()
	}

	public func asDirection() throws -> Direction {
		
		do {
			return try directionAssumingIntValue()
		}
		catch { throw error }
	}
	
}
