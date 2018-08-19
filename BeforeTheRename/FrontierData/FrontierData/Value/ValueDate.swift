//
//  ValueDate.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/21/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

// Mac dates, before OS X, started January 1, 1904.
// This is the number of seconds between old Mac dates and Unix dates.
private let unixEpochMinusOldMacEpoch = 2082844800.0

extension Date: Value {
	
	public var valueType: ValueType {
		get {
			return .date
		}
	}
	
	public func asDouble() throws -> Double {
		
		return timeIntervalSince1904
	}
	public init(timeIntervalSince1904: TimeInterval) {
		
		self.init(timeIntervalSince1970: timeIntervalSince1904 - unixEpochMinusOldMacEpoch)
	}
}

private extension Date {
	
	var timeIntervalSince1904: TimeInterval {
		get {
			return timeIntervalSince1970 + unixEpochMinusOldMacEpoch
		}
	}
}
