//
//  ParamInfo.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/24/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

private enum OperationParamInfo {
	
	case evaluateNone
	case evaluateBoth
	case evaluateFirst
	case evaluateSecond
	
	func evaluateParam1() -> Bool {
		return self == .evaluateBoth || self == .evaluateFirst
	}
	
	func evaluateParam2() -> Bool {
		return self == .evaluateBoth || self == .evaluateSecond
	}
}

extension CodeTreeNodeType {
	
	private static let operationParamInfo: [CodeTreeNodeType: OperationParamInfo] = [
		noOp: .evaluateNone,
		addOp: .evaluateBoth,
		subtractOp: .evaluateBoth,
		multiplyOp: .evaluateBoth,
		divideOp: .evaluateBoth,
		modOp: .evaluateBoth,
		identifierOp: .evaluateNone,
		constOp: .evaluateNone,
		unaryOp: .evaluateFirst,
		notOp: .evaluateFirst,
		assignOp: .evaluateSecond,
		functionOp: .evaluateNone,
		equalsOp: .evaluateBoth,
		notEqualsOp: .evaluateBoth,
		greaterThanOp: .evaluateBoth,
		lessThanOp: .evaluateBoth,
		greaterThanEqualsOp: .evaluateBoth,
		lessThanEqualsOp: .evaluateBoth,
		orOrOp: .evaluateFirst,
		andAndOp: .evaluateFirst,
		incrementPreOp: .evaluateNone,
		incrementPostOp: .evaluateNone,
		decrementPreOp: .evaluateNone,
		decrementPostOp: .evaluateNone,
		loopOp: .evaluateFirst,
		fileLoopOp: .evaluateNone,
		forLoopOp: .evaluateBoth,
		breakOp: .evaluateNone,
		returnOp: .evaluateFirst,
		bundleOp: .evaluateNone,
		ifOp: .evaluateFirst,
		procOp: .evaluateNone,
		localOp: .evaluateNone,
		moduleOp: .evaluateNone,
		dotOp: .evaluateNone,
		arrayOp: .evaluateNone,
		addressOfOp: .evaluateNone,
		dereferenceOp: .evaluateNone,
		assignLocalOp: .evaluateBoth,
		bracketOp: .evaluateNone,
		caseOp: .evaluateNone,
		caseItemOp: .evaluateNone,
		caseBodyOp: .evaluateNone,
		kernelOp: .evaluateNone,
		continueOp: .evaluateNone,
		withOp: .evaluateNone,
		forDownLoopOp: .evaluateBoth,
		tryOp: .evaluateNone,
		beginsWithOp: .evaluateBoth,
		endsWithOp: .evaluateBoth,
		containsOp: .evaluateBoth,
		rangeOp: .evaluateBoth,
		listOp: .evaluateNone,
		fieldOp: .evaluateNone,
		recordOp: .evaluateNone,
		forInLoopOp: .evaluateFirst,
		globalOp: .evaluateNone,
		osaScriptOp: .evaluateFirst,
		addValueOp: .evaluateSecond,
		subtractValueOp: .evaluateSecond,
		multiplyValueOp: .evaluateSecond,
		divideValueOp: .evaluateSecond
	]

	private var paramInfo: OperationParamInfo {
		get {
			return CodeTreeNodeType.operationParamInfo[self]!
		}
	}
	
	var shouldEvaluateParam1: Bool {
		get {
			return paramInfo.evaluateParam1()
		}
	}
	
	var shouldEvaluateParam2: Bool {
		get {
			return paramInfo.evaluateParam2()
		}
	}
}
