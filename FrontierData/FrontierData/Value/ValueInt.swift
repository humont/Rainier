//
//  ValueInt.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/21/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension Int: Value {
	
	public var valueType: ValueType {
		get {
			return .int
		}
	}
	
	public func asBool() throws -> Bool {
		
		return self != 0
	}
	
	public func asChar() throws -> CChar {
		
		return charAssumingIntValue()
	}
	
	public func asInt() throws -> Int {
		
		return self
	}
	
	public func asDouble() throws -> Double {
		
		return doubleAssumingIntValue()
	}
	
	public func asDate() throws -> Date {
		
		return dateAssumingDoubleValue()
	}
	
	public func asDirection() throws -> Direction {
		
		do {
			return try directionAssumingIntValue()
		}
		catch { throw error }
	}
	
	public func asEnumValue() throws -> EnumValue {
		
		return enumValueAssumingIntValue()
	}
	
	public func asString() throws -> String {
		
		return stringAssumingInterpolation()
	}
	
	public func asList() throws -> List {
		
		return listWithValue()
	}
	
	public func unaryMinusValue() throws -> Value {
		
		return 0 - self
	}
}
