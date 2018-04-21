//
//  CodeTreeNode.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/20/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// CodeTreeNodes are immutable, so that a tree, once built, can be evaluated many times.
// They’re also thread-safe — the same tree could be evaluated on multiple threads at once.

public protocol CodeTreeNode: class {
	
	var operation: CodeTreeOperation { get }
	var textPosition: TextPosition { get }

	// breakOperation must be one of .breakOp, .returnOp, .continueOp, or .noOp
	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value
}
