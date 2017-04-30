//
//  Constants.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/29/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// OrigFrontier: langstartup.c

struct Constants {

	static let constantsTable: HashTable = {

		let t = HashTable("constants", Tables.languageTable)

		t.add("nil", emptyValue)
		t.add("infinity", Int.max)
		t.add("up", Direction.up)
		t.add("down", Direction.down)
		t.add("left", Direction.left)
		t.add("right", Direction.right)
		t.add("flatup", Direction.flatUp)
		t.add("flatdown", Direction.flatDown)
		t.add("nodirection", Direction.noDirection)
		t.add("pageup", Direction.pageUp)
		t.add("pagedown", Direction.pageDown)
		t.add("pageleft", Direction.pageLeft)
		t.add("pageright", Direction.pageRight)
		t.add("true", true)
		t.add("false", false)

		valueTypesAppearingInConstantsTable.forEach { (oneValueType) in

			t.add(oneValueType.constantsTableName(), oneValueType.osType())
		}

		t.add("shortType", OSType("shor")) // Special case to match coercion verb

		t.add("machinePPC", "PowerPC");
		t.add("machine68K", "68K");
		t.add("machineX86", "x86");

		t.add("osMacOS", "MacOS");
		//Code change by Timothy Paustian Tuesday, July 11, 2000 9:41:39 PM
		//We add a detection for the carbon environment
		t.add("osMacCn", "MacCn");
		t.add("osWin95", "Win95");
		t.add("osWinNT", "WinNT");

		t.add("osMacCocoa", "MacOS 64-bit Cocoa")

		t.isReadOnly = true
		
		return t
	}()

	static func lookup(_ identifier: String) -> Any? {

		return constantsTable.lookup(identifier)
	}
}

private let valueTypesAppearingInConstantsTable: Set<ValueType> = Set([.noValue, .char, .int, .binary, .boolean, .token, .date, .address, .code, .double, .string, .direction, .osType, .enumValue, .list, .record, .outline, .word, .table, .script, .menu])

private let displayNames: [ValueType: String] = [.uninitialized: "", .noValue: "unknown", .char: "char", .int: "int", .long: "long", .oldString: "string", .binary: "binary", .boolean: "boolean", .token: "token", .date: "date", .address: "address", .code: "code", .double: "double", .string: "string", .external: "external", .direction: "direction", .password: "password", .osType: "string4", .unused: "unused", .point: "point", .qdRect: "QuickDraw rect", .qdPattern: "QuickDraw pattern", .qdRGB: "QuickDraw RGB", .fixed: "fixed", .single: "single", .oldDouble: "double", .objSpec: "objspec", .fileSpec: "filespec", .alias: "alias", .enumValue: "enumerator", .list: "list", .record: "record", .outline: "outline", .word: "wp text", .head: "head", .table: "table", .script: "script", .menu: "menubar", .qdPict: "QuickDraw pict"]

private let osTypeStrings: [ValueType: String] = [.uninitialized: "0000", .noValue: "????", .char: "char", .int: "shor", .long: "long", .oldString: "ostr", .binary: "data", .boolean: "bool", .token: "tokn", .date: "date", .address: "addr", .code: "code", .double: "exte", .string: "TEXT", .external: "extn", .direction: "dir ", .password: "pass", .osType: "type", .unused: "unus", .point: "QDpt", .qdRect: "qdrt", .qdPattern: "tptn", .qdRGB: "cRGB", .fixed: "fixd", .single: "sing", .oldDouble: "odub", .objSpec: "obj ", .fileSpec: "fss ", .alias: "alis", .enumValue: "enum", .list: "list", .record: "reco", .outline: "optx", .word: "wptx", .head: "head", .table: "tabl", .script: "scpt", .menu: "mbar", .qdPict: "pict"]

private extension ValueType {

	func appearsInConstantsTable() -> Bool {

		return valueTypesAppearingInConstantsTable.contains(self)
	}

	func constantsTableName() -> String {

		return displayName() + "Type"
	}

	func displayName() -> String {

		return displayNames[self]!
	}

	func osType() -> OSType {

		return OSType(osTypeStrings[self]!)
	}
}


