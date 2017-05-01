//
//  TreeType.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/20/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

public typealias CodeTreeNodeType = Int

let noOp = 0
let addOp = 1
let subtractOp = 2
let multiplyOp = 3
let divideOp = 4
let modOp = 5
let identifierOp = 6
let constOp = 7
let unaryOp = 8
let notOp = 9
let assignOp = 10
let functionOp = 11
let equalsOp = 12
let notEqualsOp = 13
let greaterThanOp = 14
let lessThanOp = 15
let greaterThanEqualsOp = 16
let lessThanEqualsOp = 17
let orOrOp = 18
let andAndOp = 19
let incrementPreOp = 20
let incrementPostOp = 21
let decrementPreOp = 22
let decrementPostOp = 23
let loopOp = 24
let fileLoopOp = 25
let forLoopOp = 26
let breakOp = 27
let returnOp = 28
let bundleOp = 29
let ifOp = 30
let procOp = 31
let localOp = 32
let moduleOp = 33
let dotOp = 34
let arrayOp = 35
let addressOfOp = 36
let dereferenceOp = 37
let assignLocalOp = 38
let bracketOp = 39
let caseOp = 40
let caseItemOp = 41
let caseBodyOp = 42
let kernelOp = 43
let continueOp = 44
let withOp = 45
let forDownLoopOp = 46
let tryOp = 47
let beginsWithOp = 48
let endsWithOp = 49
let containsOp = 50
let rangeOp = 51
let listOp = 52
let fieldOp = 53
let recordOp = 54
let forInLoopOp = 55
let globalOp = 56
let osaScriptOp = 57
let addValueOp = 58
let subtractValueOp = 59
let multiplyValueOp = 60
let divideValueOp = 61



