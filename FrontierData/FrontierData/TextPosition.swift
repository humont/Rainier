//
//  TextPosition.swift
//  FrontierData
//
//  Created by Brent Simmons on 5/2/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

public struct TextPosition {

	public let lineNumber: Int
	public let characterIndex: Int

	public init(_ lineNumber: Int, _ characterIndex: Int) {

		self.lineNumber = lineNumber
		self.characterIndex = characterIndex
	}

	public static func start() -> TextPosition {

		return TextPosition(0, 0)
	}

	public func nextLine() -> TextPosition {

		return TextPosition(lineNumber + 1, 0)
	}

	public func nextCharacter() -> TextPosition {

		return TextPosition(lineNumber, characterIndex + 1)
	}
}
