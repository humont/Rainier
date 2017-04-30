//
//  Environment.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/30/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// system.environment
// OrigFrontier: langstartup.c

struct Environment {

	static let table: HashTable = {

		let t = HashTable("environment", Tables.systemTable)

		// TODO: system version, app version, etc.: see langstartup.c:226

		t.add("isMac", true)
		t.add("isWindows", false)
		t.add("isCarbon", false)
		t.add("isCocoa", true)
		t.add("is64Bit", true)
		t.add("isMacOsClassic", false)
		t.add("maxTcpConnections", Int.max) // TODO
		t.add("isPike", false)
		t.add("isRadio", false)
		t.add("isOPMLEditor", Config.isOPMLEditor)
		t.add("isFrontier", Config.isFrontier)
		
		t.isReadOnly = true

		return t
	}()

	static func lookup(_ identifier: String) -> Value? {

		return constantsTable.lookup(identifier) as? Value
	}
}

