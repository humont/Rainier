//
//  Value.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/20/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

// Go with asBool etc. because boolValue and similar conflict with existing methods.

public let emptyValue: Value = NSNull()

public protocol Value {
	
	var valueType: ValueType { get }
	
	// Coercions -- the default implementations all throw a LangError.
	func asBool() throws -> Bool
	func asChar() throws -> CChar
	func asInt() throws -> Int
	func asDouble() throws -> Double
	func asDate() throws -> Date
	func asDirection() throws -> Direction
	func asOSType() throws -> OSType
	func asEnumValue() throws -> EnumValue
	func asString() throws -> String
	func asFileSpec() throws -> String
	func asAddress() throws -> Address
	func asBinary() throws -> Data
	func asList() throws -> List
	func asRecord() throws -> Record
	
	// Operations
	
	func unaryMinusValue() throws -> Value
	func not() throws -> Bool
	func beginsWith(_ otherValue: Value) throws -> Bool
	func endsWith(_ otherValue: Value) throws -> Bool
	func contains(_ otherValue: Value) throws -> Bool
	func modValue(_ otherValue: Value) throws -> Value
	func add(_ otherValue: Value) throws -> Value
	func subtract(_ otherValue: Value) throws -> Value
	func divide(_ otherValue: Value) throws -> Value
	func multiply(_ otherValue: Value) throws -> Value

	// Comparisons
	
	func compareTo(_ otherValue: Value) throws -> ComparisonResult
	
	// If you implement compareTo, you can probably stick with the default version of these.
	func equals(_ otherValue: Value) throws -> Bool
	func lessThan(_ otherValue: Value) throws -> Bool
	func lessThanEqual(_ otherValue: Value) throws -> Bool
	func greaterThan(_ otherValue: Value) throws -> Bool
	func greaterThanEqual(_ otherValue: Value) throws -> Bool
}

public extension Value {
	
	func asBool() throws -> Bool {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asChar() throws -> CChar {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asInt() throws -> Bool {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asDate() throws -> Date {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asDouble() throws -> Double {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asDirection() throws -> Direction {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asEnumValue() throws -> EnumValue {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asOSType() throws -> OSType {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asBinary() throws -> Data {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asAddress() throws -> Address {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asString() throws -> String {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asFileSpec() throws -> String {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asList() throws -> List {
		
		throw LangError(.coercionNotPossible)
	}
	
	func asRecord() throws -> Record {
		
		throw LangError(.coercionNotPossible)
	}
	
	static func commonCoercionType(with otherValue: Value) -> ValueType {
		
		return valueType.commonCoercionType(otherValueType: otherValue.valueType)
	}

	static func compareValues<T:Comparable>(_ v1: T, _ v2: T) -> ComparisonResult {
		
		if v1 == v2 {
			return .orderedSame
		}
		return v1 < v2 ? .orderedAscending : .orderedDescending
	}
	
	static func compareTwoValues(_ value1: Value, _ value2: Value) throws -> ComparisonResult {
		
		let coercionType = value1.commonCoercionType(with: value2)
		
		switch coercionType {
			
		case .none:
			return .orderedSame
			
		case .bool, .char, .int, .direction:
			return compareValues(value1.asInt!, value2.asInt!)
			
		case .date, .double:
			return compareValues(value1.asDouble!, value2.asDouble!)
			
		case .string:
			return compareValues(value1.asString!, value2.asString!)
			
		default:
			throw LangError(.coercionNotPossible)
		}
	}

	func compareTo(_ otherValue: Value) throws -> ComparisonResult {
		
		do {
			return try Value.compareTwoValues(self, otherValue)
		}
		catch { throw error }
	}
	
	func equals(_ otherValue: Value) throws -> Bool {
		
		do {
			let comparisonResult = try compareTo(otherValue)
			return comparisonResult == .orderedSame
		}
		catch { throw error }
	}
	
	func unaryMinusValue() throws -> Value {
		
		throw LangError(.unaryMinusNotPossible)
	}
	
	func not() throws -> Bool {
		
		throw LangError(.booleanCoerce)
	}
	
	func beginsWith(_ otherValue: Value) throws -> Bool {
		
		return false // TODO
	}
	
	func endsWith(_ otherValue: Value) throws -> Bool {
		
		return false // TODO
	}
	
	func contains(_ otherValue: Value) throws -> Bool {
		
		return false // TODO
	}
	
	func lessThan(_ otherValue: Value) throws -> Bool {
		
		do {
			let comparisonResult = try compareTo(otherValue)
			return comparisonResult == .orderedAscending
		}
		catch { throw error }
	}
	
	func lessThanEqual(_ otherValue: Value) throws -> Bool {
		
		do {
			let comparisonResult = compareTo(otherValue)
			return comparisonResult == .orderedAscending || comparisonResult == .orderedSame
		}
		catch { throw error }
	}
	
	func greaterThan(_ otherValue: Value) throws -> Bool {
		
		do {
			let comparisonResult = compareTo(otherValue)
			return comparisonResult == .orderedDescending
		}
		catch { throw error }
	}
	
	func greaterThanEqual(_ otherValue: Value) throws -> Bool {
		
		do {
			let comparisonResult = compareTo(otherValue)
			return comparisonResult == .orderedDescending || comparisonResult == .orderedSame
		}
		catch { throw error }
	}
	
	func modValue(_ otherValue: Value) throws -> Value {
		
		return 0 // TODO
	}
	
	func add(_ otherValue: Value) throws -> Value {
		
		return 0 // TODO
	}
	
	func subtract(_ otherValue: Value) throws -> Value {
		
		return 0 // TODO
	}
	
	func divide(_ otherValue: Value) throws -> Value {
		
		return 0 // TODO
	}
	
	func multiply(_ otherValue: Value) throws -> Value {
		
		return 0 // TODO
	}
}

// MARK: Coercion Utilities

internal extension Value {
	
	func boolAssumingIntValue() -> Bool {
		
		return try! asInt() != 0
	}
	
	func charAssumingIntValue() -> CChar {
		
		return try! Char(asInt())
	}
	
	func doubleAssumingIntValue() -> Double {
		
		return try! Double(asInt())
	}
	
	func dateAssumingDoubleValue() -> Date {
		
		return try! Date(timeIntervalSince1904: asDouble())
	}
	
	func directionAssumingIntValue() throws -> Direction {
		
		do {
			if let d = Direction(rawValue: asInt()) {
				return d
			}
			throw LangError(.coercionNotPossible)
		}
		catch { throw error }
	}
	
	func osTypeAssumingIntValue() -> OSType {
		
		return OSType("none") // TODO
	}
	
	func enumValueAssumingIntValue() -> EnumValue {
		
		return EnumValue(osType: osTypeAssumingIntValue())
	}

	func stringAssumingInterpolation() -> String {
		
		return "\(self)"
	}
	
	func listWithValue() -> List {
		
		return List([self])
	}
}

