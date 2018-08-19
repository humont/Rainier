//
//  ValueDirection.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/21/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension Direction: Value {
	
	public var valueType: ValueType {
		get {
			return .direction
		}
	}
	
	public func asBool() throws -> Bool {
		
		return boolAssumingIntValue()
	}
	
	public func asInt() throws -> Int {
		
		return rawValue
	}
	
	public func asDouble() throws -> Double {
		
		return doubleAssumingIntValue()
	}
	
	public func asDate() throws -> Date {
		
		return dateAssumingDoubleValue()
	}
	
	public func asDirection() throws -> Direction {
		
		return self
	}
}
