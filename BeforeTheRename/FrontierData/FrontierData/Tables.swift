//
//  TableStructure.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/29/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

let rootTableName = "root"
let systemTableName = "system"
let compilerTableName = "compiler"
let languageTableName = "language"

public struct Tables {

	public static let rootTable = HashTable(rootTableName, nil)
	public static let systemTable = HashTable(systemTableName, rootTable)
	public static let compilerTable = HashTable(compilerTableName, systemTable)
	public static let languageTable = HashTable(languageTableName, compilerTable)

}
