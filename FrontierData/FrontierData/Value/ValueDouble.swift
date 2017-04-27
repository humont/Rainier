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
	
	func asBool() throws -> Bool {
		
		return boolAssumingIntValue()
	}
	
	func asChar() throws -> CChar {
		
		return charAssumingIntValue()
	}
	
	func asInt() throws -> Int {
		
		return Int(self)
	}
	
	func asDouble() throws -> Double {
		
		return self
	}
	
	func asDate() throws -> Date {
		
		return dateAssumingDoubleValue()
	}
	
	func asDirection() throws -> Direction {
		
		throw LangError(.coercionNotPossible) //Checked: “Can’t coerce a double value to a direction.”
	}
	
	func asOSType() throws -> OSType {
		
		return osTypeAssumingIntValue()
	}
	
	func asEnumValue() throws -> EnumValue {
		
		return enumValueAssumingIntValue()
	}
	
	func asString() throws -> String {
		
		return stringAssumingInterpolation()
	}
	
	func asList() throws -> List {
		
		return listWithValue()
	}

	public func unaryMinusValue() throws -> Value {
		
		return 0 - self
	}
}
