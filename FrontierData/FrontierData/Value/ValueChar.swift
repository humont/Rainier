//
//  ValueChar.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/21/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension CChar: Value {
	
	public var valueType: ValueType {
		get {
			return .char
		}
	}
	
	public func asBool() throws -> Bool {
		
		return boolAssumingIntValue()
	}
	
	public func asChar() throws -> CChar {
		
		return self
	}
	
	public func asInt() throws -> Int {
		
		return Int(self)
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
