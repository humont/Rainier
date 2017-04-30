//
//  Builtins.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/30/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

// OrigFrontier: langstartup.c

// system.compiler.language.builtins

let appleeventfunc = 0
let complexeventfunc = 1
let findereventfunc = 2
let tableeventfunc = 3
let objspecfunc = 4
let setobjspecfunc = 5
let packfunc = 6
let unpackfunc = 7
let definedfunc = 8
let typeoffunc = 9
let sizeoffunc = 10
let nameoffunc = 11
let parentoffunc = 12
let indexoffunc = 13
let gestaltfunc = 14
let syscrashfunc = 15
let myMooffunc = 16


struct Builtins {

	static let builtinsTable: HashTable = {

		let t = HashTable("builtins", Tables.languageTable)

		t.add("appleevent", appleeventfunc)
		t.add("complexevent", complexeventfunc)
		t.add("finderevent", findereventfunc)
		t.add("tableevent", tableeventfunc)
		t.add("objspec", objspecfunc)
		t.add("setobj", setobjspecfunc)
		t.add("pack", packfunc)
		t.add("unpack", unpackfunc)
		t.add("defined", definedfunc)
		t.add("typeof", typeoffunc)
		t.add("sizeof", sizeoffunc)
		t.add("nameof", nameoffunc)
		t.add("parentof", parentoffunc)
		t.add("indexof", indexoffunc)
		t.add("gestalt", gestaltfunc)
		t.add("syscrash", syscrashfunc)
		t.add("myMoof", myMooffunc)

		t.isReadOnly = true

		return t
	}()

	static func lookup(_ identifier: String) -> Int? {

		return keywordTable.lookup(identifier) as? Int
	}
}
