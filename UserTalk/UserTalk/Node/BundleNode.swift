//
//  BundleNode.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/7/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class BundleNode: CodeTreeNode {

	let operation = .bundleOp
	let textPosition: TextPosition
	let blockNode: BlockNode

	init(_ textPosition: TextPosition, _ blockNode: BlockNode) {

		self.blockNode = blockNode
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		stack.push(self)
		defer {
			stack.pop()
		}

		do {
			try return blockNode.evaluate(stack, breakOperation)
		}
		catch { throw error }
	}
}
