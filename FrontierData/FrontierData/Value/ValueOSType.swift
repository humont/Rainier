//
//  ValueOSType.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/21/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

extension OSType: Value {
	
	public var valueType: ValueType {
		get {
			return .osType
		}
	}
}

