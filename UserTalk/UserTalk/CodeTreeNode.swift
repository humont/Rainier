//
//  CodeTreeNode.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/20/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

protocol CodeTreeNode: class {
	
	var operation: CodeTreeOperation { get }
	var textPosition: TextPosition { get }

	// breakOperation must be one of .breakOp, .returnOp, .continueOp, or .noOp
	func evaluate(_ breakOperation: inout CodeTreeOperation) throws -> Value
}
