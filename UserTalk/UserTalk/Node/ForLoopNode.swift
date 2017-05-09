//
//  ForLoopNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// for counter = n1 to n2 // ForLoopNode (with RangeNode)
//   script() //BlockNode

final class ForLoopNode: CodeTreeNode {

	let operation: CodeTreeOperation = .forLoopOp
	let textPosition: textPosition
	let counterNode: CodeTreeNode
	let rangeNode: RangeNode
	let blockNode: BlockNode

	init(_ textPosition: TextPosition, _ counterNode: CodeTreeNode, _ rangeNode: RangeNode, _ blockNode: BlockNode) {

		self.textPosition = textPosition
		self.rangeNode = rangeNode
		self.blockNode = blockNode
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		let ascending = rangeNode.ascending

		do {
			try let (startIndex, endIndex) = rangeNode.startAndEndIndex()
		}
		catch { throw error }

		let ix = startIndex

		while true {

			var innerBreakOperation: CodeTreeOperation = .noOp
			stack.push(blockNode)
			defer {
				stack.pop()
			}

			do {
				try blockNode.evaluate(stack, &innerBreakOperation)
			}
			catch { throw error }

			if innerBreakOperation == .breakOp {
				break
			}
			if innerBreakOperation == .returnOp {
				breakOperation = .returnOp
				break
			}

			if ix == endIndex {
				break
			}
			if ascending {
				ix += 1
			}
			else {
				ix -= 1
			}
		}

		return ix
	}
}
