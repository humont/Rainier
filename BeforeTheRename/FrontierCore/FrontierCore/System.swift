//
//  System.swift
//  FrontierCore
//
//  Created by Brent Simmons on 4/30/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

public struct System {

	public static func osVersion() -> OperatingSystemVersion {

		return ProcessInfo.processInfo.operatingSystemVersion
	}

	public static func osBuildString() -> String? {

		return runUnixCommand("/usr/bin/sw_vers", ["-buildVersion"])
	}

	public static func localizedOSName() -> String {

		return ProcessInfo.processInfo.operatingSystemVersionString
	}

	public static func runUnixCommand(_ appPath: String, _ parameters: [String]) -> String? {

		let process = Process()
		process.launchPath = appPath
		process.arguments = parameters

		let pipe = Pipe()
		process.standardOutput = pipe

		process.launch()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()

		return String(data: data, encoding: .utf8)
	}
}
