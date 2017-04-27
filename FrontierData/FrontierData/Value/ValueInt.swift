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
	
	func asBool() throws -> Bool {
		
		return self != 0
	}
	
	func asChar() throws -> CChar {
		
		return charAssumingIntValue()
	}
	
	func asInt() throws -> Int {
		
		return self
	}
	
	func asDouble() throws -> Double {
		
		return doubleAssumingIntValue()
	}
	
	func asDate() throws -> Date {
		
		return dateAssumingDoubleValue()
	}
	
	func asDirection() throws -> Direction {
		
		do {
			return try! directionAssumingIntValue()
		}
		catch { throw error }
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
