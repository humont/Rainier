//
//  Tokenizer.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/29/17.
//  Copyright ©2017 Ranchero Software. All rights reserved.
//

import Foundation

enum LangToken: Int {
	
	case emptyToken = 0
	case EQToken = 400
	case NEToken = 401
	case GTToken = 402
	case LTToken = 403
	case GEToken = 404
	case LEToken = 405
	case notToken = 406
	case andandToken = 407
	case ororToken = 408
	case beginswithToken = 409
	case endswithToken = 410
	case containsToken = 411
	case bitandToken = 412
	case bitorToken = 413
	case loopToken = 500
	case fileloopToken = 501
	case inToken = 502
	case breakToken = 503
	case returnToken = 504
	case ifToken = 505
	case thenToken = 506
	case elseToken = 507
	case bundleToken = 508
	case localToken = 509
	case onToken = 510
	case whileToken = 511
	case caseToken = 512
	case kernelToken = 513
	case forToken = 514
	case toToken = 515
	case downtoToken = 516
	case continueToken = 517
	case withToken = 518
	case tryToken = 519
	case globalToken = 520
	case errorToken = 292
	case eolToken = 293
	case constantToken = 294
	case identifierToken = 295
	case otherToken = 296
	case assignToken = 297
	case addToken = 298
	case subtractToken = 299
	case multiplyToken = 300
	case divideToken = 301
	case modToken = 302
	case plusplusToken = 303
	case minusminusToken = 304
	case unaryminus = 305
}


class Tokenizer {
	
	var flSentEOL = false
	
	func parseGetToken(_ node: CodeTreeNode) -> Int {
		
		return langScanner(node).rawValue
	}
}

private let singleQuote: Character = "'"
private let startComment: Character = "«"
private let forwardSlash: Character = "/"

private extension Tokenizer {
	
	func langScanner(_ nodeToken: CodeTreeNode) -> LangToken {
		
		var nodeToken: CodeTreeNode? = nil
		var ch: Character? = nil
		var chFirst: Character? = nil
		var chSecond: Character? = nil
		
		if !parsePopBlanks() { /*ran out of text*/
			if flSentEOL {
				return LangToken.emptyToken
			}
			flSentEOL = true
			return LangToken.eolToken
		}
		
		chFirst = parseFirstChar()
		ch = chFirst
		
		if ch == singleQuote { /*a single-quote, character constant*/
			
			guard let val = parsePopCharConst() else {
				return errorToken
			}
			
		}
		
		return LangToken.eolToken //TODO: real value
	}
	
	func parsePopBlanks() -> Bool {
		
		var ch: Character? = nil
		
		while true {
			
			if parseStringEmpty() {
				return false
			}
			
			ch = parseFirstChar()
			
			if ch == startComment || (ch == forwardSlash && parseNextChar() == forwardSlash) {
				parsePopComment()
			}
			else {
				
			}
		}
	}
}
