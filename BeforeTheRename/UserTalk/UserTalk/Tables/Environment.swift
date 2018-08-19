//
//  Environment.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/30/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData
import FrontierCore

// system.environment
// OrigFrontier: langstartup.c

struct Environment {

	static let table: HashTable = {

		let t = HashTable("environment", Tables.systemTable)

		t.add("isMac", true)
		t.add("isWindows", false)
		t.add("isCarbon", false)
		t.add("isCocoa", true)
		t.add("is64Bit", true)
		t.add("isMacOsClassic", false)
		t.add("maxTcpConnections", Int.max) // TODO: ?
		t.add("isPike", false)
		t.add("isRadio", false)
		t.add("isOPMLEditor", Config.isOPMLEditor)
		t.add("isFrontier", Config.isFrontier)

		let osVersion = System.osVersion()
		t.add("osMajorVersion", "\(osVersion.majorVersion)")
		t.add("osMinorVersion", "\(osVersion.minorVersion)")
		t.add("osPointVersion", "\(osVersion.patchVersion)")

		if let buildString = System.osBuildString() {
			t.add("osBuildNumber", buildString)
		}
		else {
			t.add("osBuildNumber", "unknown")
		}

		t.add("osFullNameForDisplay", System.localizedOSName())

		t.isReadOnly = true

		return t
	}()

	static func lookup(_ identifier: String) -> Value? {

		return table.lookup(identifier) as? Value
	}
}

