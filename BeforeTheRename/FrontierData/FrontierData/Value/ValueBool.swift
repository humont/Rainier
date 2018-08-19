//
//  ValueBool.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/21/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension Bool: Value {
	
	public var valueType: ValueType {
		get {
			return .boolean
		}
	}
	
	public func asBool() throws -> Bool {
		
		return self
	}
	
	public func asChar() throws -> CChar {
		
		return CChar(self ? 1 : 0)
	}
	
	public func asInt() throws -> Int {
		let n = self ? 1 : 0
		return n
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
	
	public func asOSType() throws -> OSType {
		
		return osTypeAssumingIntValue()
	}
	
	public func asString() throws -> String {
		
		return self ? "true" : "false"
	}
	
	public func asList() throws -> List {
		
		return listWithValue()
	}
	
	public func unaryMinusValue() throws -> Value {
		
		return self
	}

}
