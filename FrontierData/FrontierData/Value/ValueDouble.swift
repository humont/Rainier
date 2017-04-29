//
//  ValueDouble.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/22/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension Double: Value {
	
	public var valueType: ValueType {
		get {
			return .double
		}
	}
	
	public func asBool() throws -> Bool {
		
		return boolAssumingIntValue()
	}
	
	public func asChar() throws -> CChar {
		
		return charAssumingIntValue()
	}
	
	public func asInt() throws -> Int {
		
		return Int(self)
	}
	
	public func asDouble() throws -> Double {
		
		return self
	}
	
	public func asDate() throws -> Date {
		
		return dateAssumingDoubleValue()
	}
	
	public func asDirection() throws -> Direction {
		
		throw LangError(.coercionNotPossible) //Checked: “Can’t coerce a double value to a direction.”
	}
	
	public func asOSType() throws -> OSType {
		
		return osTypeAssumingIntValue()
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
