//
//  RangeNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// for x = 5 to 90
// for x = 90 downto 5
// The "5 to 90" and "90 downto 5" parts are RangeNodes.

final class RangeNode: CodeTreeNode {

	let operation: CodeTreeOperation = .rangeOp
	let textPosition: TextPosition
	let startIndexNode: CodeTreeNode
	let endIndexNode: CodeTreeNode
	let ascending: Bool

	init(_ textPosition: TextPosition, _ startIndexNode: CodeTreeNode, _ endIndexNode: CodeTreeNode, _ ascending: Bool) {

		self.textPosition = textPosition
		self.startIndex = startIndex
		self.endIndex = endIndex
		self.ascending = ascending
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		preconditionFailure("A RangeNode should never be evaluated.")
	}

	func startAndEndIndex() throws -> (Int, Int) {

		// Evaluates on each call.

		let startIndex: Int
		let endIndex: Int
		var ignoredBreakOperation: CodeTreeOperation = .noOp

		do {
			startIndex = try startIndexNode.evaluate(stack, &ignoredBreakOperation).asInt()
			endIndex = try endIndexNode.evaluate(stack, &ignoredBreakOperation).asInt()
		}
		catch { throw error }

		return (startIndex, endIndex)
	}
}
