//
//  CodeTreeNodeType.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/20/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

public enum CodeTreeOperation: Int {

	case noOp = 0
	case addOp = 1
	case subtractOp = 2
	case multiplyOp = 3
	case divideOp = 4
	case modOp = 5
	case identifierOp = 6
	case constOp = 7
	case unaryOp = 8
	case notOp = 9
	case assignOp = 10
	case functionOp = 11
	case equalsOp = 12
	case notEqualsOp = 13
	case greaterThanOp = 14
	case lessThanOp = 15
	case greaterThanEqualsOp = 16
	case lessThanEqualsOp = 17
	case orOrOp = 18
	case andAndOp = 19
	case incrementPreOp = 20
	case incrementPostOp = 21
	case decrementPreOp = 22
	case decrementPostOp = 23
	case loopOp = 24
	case fileLoopOp = 25
	case forLoopOp = 26
	case breakOp = 27
	case returnOp = 28
	case bundleOp = 29
	case ifOp = 30
	case procOp = 31
	case localOp = 32
	case moduleOp = 33
	case dotOp = 34
	case arrayOp = 35
	case addressOfOp = 36
	case dereferenceOp = 37
	case assignLocalOp = 38
	case bracketOp = 39
	case caseOp = 40
	case caseItemOp = 41
	case caseBodyOp = 42
	case kernelOp = 43
	case continueOp = 44
	case withOp = 45
	case forDownLoopOp = 46
	case tryOp = 47
	case beginsWithOp = 48
	case endsWithOp = 49
	case containsOp = 50
	case rangeOp = 51
	case listOp = 52
	case fieldOp = 53
	case recordOp = 54
	case forInLoopOp = 55
	case globalOp = 56
	case osaScriptOp = 57
	case addValueOp = 58
	case subtractValueOp = 59
	case multiplyValueOp = 60
	case divideValueOp = 61
}

