//
//  File.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/3/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

final class SimpleOperationNode: CodeTreeNode {

	let operation: CodeTreeOperation
	let textPosition: TextPosition

	init(_ operation: CodeTreeOperation, _ textPosition: TextPosition) {

		precondition(operation == .breakOp || operation == .continueOp || operation == .noOp)
		self.operation = operation
	}

	func evaluate(_ stack: Stack, _ breakOperation: inout CodeTreeOperation) throws -> Value {

		breakOperation = operation
		return true
	}
}

func breakOperationNode(_ textPosition: TextPosition) -> SimpleOperationNode {

	return SimpleOperationNode(.breakOp, textPosition)
}

func continueOperationNode(_ textPosition: TextPosition) -> SimpleOperationNode {

	return SimpleOperationNode(.continueOp, textPosition)
}

func noOpOperationNode(_ textPosition: TextPosition) -> SimpleOperationNode {

	return SimpleOperationNode(.noOp, textPosition)
}
