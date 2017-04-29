//
//  ValueList.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/22/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension List: Value {
	
	public var valueType: ValueType {
		get {
			return .list
		}
	}
	
	public func equals(_ otherValue: Value) throws -> Bool {
		
		guard let otherList = otherValue as? List else {
			return false
		}
		
		return isEqualTo(otherList)
	}
}
