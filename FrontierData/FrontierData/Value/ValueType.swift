//
//  ValueType.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/20/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

public enum ValueType: Int {

	// Use care -- the numbers are saved on disk inside symbol tables.

	case uninitialized = -1
	case noValue = 0
	case char = 1
	case int = 2
	case long = 3
	case oldString = 4
	case binary = 5
	case boolean = 6
	case token = 7
	case date = 8
	case address = 9
	case code = 10
	case double = 11
	case string = 12
	case external = 13
	case direction = 14
	case password = 15
	case osType = 16
	case unused = 17
	case point = 18
	case qdRect = 19
	case qdPattern = 20
	case qdRGB = 21
	case fixed = 22
	case single = 23
	case oldDouble = 24
	case objSpec = 25
	case fileSpec = 26
	case alias = 27
	case enumValue = 28
	case list = 29
	case record = 30

	/* The following value types, outline - pictvaluetype, are never used directly.
	The value would actually be .external; these are for flattening
	external types into a ValueType. */

	case outline = 31
	case word = 32
	case head = 33
	case table = 34
	case script = 35
	case menu = 36
	case qdPict = 37
}

public extension ValueType {
	
	// MARK: Coercion
	
	func commonCoercionType(otherValueType: ValueType) -> ValueType {
		
		if self == otherValueType {
			return self
		}
		
		if self.coercionWeight() >= otherValueType.coercionWeight() {
			return self
		}
		return otherValueType
	}
	
	func coercionWeight() -> Int {
		
		// OrigFrontier: langvalue.c cercionweight function.
		
		switch self {
			
		case .noValue, .uninitialized:
			return 0
			
		case .boolean:
			return 1
			
		case .int, .token:
			return 2
			
		case .direction, .char, .long, .osType, .point:
			return 3
			
		case .date:
			return 4
			
		case .fixed, .single:
			return 5
			
		case .double:
			return 7
			
		case .qdRect, .qdPattern, .qdRGB, .fileSpec, .alias, .address, .external:
			return 8
			
		case .objSpec:
			return 9
			
		case .string, .password:
			return 10
			
		case .binary:
			return 11
			
		case .list:
			return 12
			
		case .record:
			return 13
			
		default:
			return 1
		}
	}
}
