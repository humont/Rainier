//
//  MathVerbs.swift
//  FrontierVerbs
//
//  Created by Brent Simmons on 4/15/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

struct MathVerbs: VerbTable {
	
	private enum Verb: String {
		case min = "min"
		case max = "max"
		case sqrt = "sqrt"
	}
	
	public static func evaluate(_ lowerVerbName: String, _ params: VerbParams, _ verbAppDelegate: VerbAppDelegate) throws -> Value {
		
		guard let verb = Verb(rawValue: lowerVerbName) else {
			throw LangError(.verbNotFound)
		}
		
		do {
			switch verb {
				
			case .min:
				return try mathMin(params)
			case .max:
				return try mathMax(params)
			case .sqrt:
				return try mathSqrt(params)
			}
		}
		catch { throw error }
	}
}

private extension MathVerbs {
	
	static func mathMin(_ params: VerbParams) throws -> Value {
		
		do {
			let (value1, value2) = try params.binaryParams()
			let comparisonResult = try value1.compareTo(value2)
			
			if comparisonResult == .orderedSame || comparisonResult == .orderedAscending {
				return value1
			}
			return value2
		}
		catch { throw error }
	}
	
	static func mathMax(_ params: VerbParams) throws -> Value {
		
		do {
			let (value1, value2) = try params.binaryParams()
			let comparisonResult = try value1.compareTo(value2)
			
			if comparisonResult == .orderedAscending {
				return value2
			}
			return value1
		}
		catch { throw error }
	}
	
	static func mathSqrt(_ params: VerbParams) throws -> Value {
		
		do {
			let value = try params.singleParam()
			let d = try value.asDouble()
			return sqrt(d)
		}
		catch { throw error }
	}
}
