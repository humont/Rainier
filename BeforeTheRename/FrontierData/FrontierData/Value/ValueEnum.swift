//
//  ValueEnum.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/21/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension EnumValue: Value {
	
	public var valueType: ValueType {
		get {
			return .enumValue
		}
	}
}
