//
//  Tokenizer.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/29/17.
//  Copyright ©2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// OrigFrontier: yytab.h
// Leaving “Token” as part of these names
// because some of them conflict with Swift keywords.

enum Token: Integer {

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
	case constantToken(Value) = 294
	case identifierToken(String) = 295
	case otherToken = 296
	case assignToken = 297
	case addToken = 298
	case subtractToken = 299
	case multiplyToken = 300
	case divideToken = 301
	case modToken = 302
	case plusplusToken = 303
	case minusminusToken = 304
	case unaryminusToken = 305
	case commaToken = 900
	case leftParenToken = 901
	case rightParenToken = 902
	case semicolonToken = 903
	case leftBraceToken = 904
	case rightBraceToken = 905
	case dotToken = 906
	case colonToken = 907
	case leftBracketToken = 908
	case rightBracketToken = 909
	case atToken = 910
	case caretToken = 911
}

struct TokenWithPosition {

	let token: Token
	let position: TextPosition

	init(_ token: Token, _ position: TextPosition) {

		self.token = token
		self.position = position
	}
}

func tokensFor(_ s: String, lineBasedScan: Bool) throws -> [TokenWithPosition] {

	var tokens = [TokenWithPosition]()

	if parseString.isEmpty {
		return tokens
	}

	let tokenizer = Tokenizer(s, lineBasedScan)
	do {
		while true {
			guard let oneToken = try tokenizer.parseGetToken() else {
				break
			}
			tokens += [oneToken]
		}
	}
	catch { throw error }

	return tokens
}

// OrigFrontier: langscan.c

private struct Tokenizer {

	var ixParseString: String.Index
	let ixEndString: String.Index
	let parseString: String
	let lineBasedScan: Bool
	var textPosition: TextPosition = TextPosition.start()

	public init(_ parseString: String, _ lineBasedScan: Bool) {

		self.parseString = parseString
		self.lineBasedScan = lineBasedScan
		self.ixParseString = parseString.startIndex
		self.ixEndString = parseString.endIndex

		super.init()

	}

	func parseGetToken() throws -> TokenWithPosition? {

		// TODO: unite with langScanner

		if parseStringEmpty() {
			return nil
		}

		do {
			return try langScanner()
		}
		catch { throw error }
	}
}

private let singleQuote: Character = "'"
private let doubleQuote: Character = "\""
private let openDoubleCurlyQuote: Character = "“"
private let closeDoubleCurlyQuote: Character = "”"
private let startComment: Character = "«"
private let endComment: Character = "»"
private let forwardSlash: Character = "/"
private let space: Character = " "
private let tab: Character = "\t"
private let lineFeed: Character = "\n"
private let carriageReturn: Character = "\r"
private let backslash: Character = "\\"

private extension Tokenizer {

	func tokenWithPosition(_ token: Token) -> TokenWithPosition {

		return TokenWithPosition(token, textPosition)
	}

	func langScanner() throws -> TokenWithPosition? {

		/*Scan the input string for the next token, return the character
		that we stopped on in chtoken.

		If it's an identifier or a constant, the returned node will be non-nil.

		11/22/91 dmb: return zero when out of text, after returning exactly
		one (non-zero) eoltoken.
		*/

		if !parsePopBlanks() { /*ran out of text*/
			return nil
		}

		let chFirst = parseFirstChar()!
		let ch = chFirst
		var token: Token?

		do {
			if ch == singleQuote { // A single-quote, character constant

				let val = try parsePopCharConst()
				token = .constantToken(val)
			}

			else if ch == doubleQuote || ch == openDoubleCurlyQuote { // A string constant

				let val = try parsePopStringConst()
				token = .constantToken(val)
			}

			else if ch.isDigit() {

				let val = parsePopNumber()
				token = .constantToken(val)
			}

			else if ch.isFirstIdentifier() {

				let identifier = parsePopIdentifier()

				if let keywordToken = Keywords.lookup(identifier) {
					token = keywordToken
				}

				else if let constantValue = Constants.lookup(identifier) {
					token = .constantToken(constantValue)
				}

				else {
					token = .identifierToken(identifier)
				}
			}

			else {
				let _ = parsePopChar() // Consume the token char
				let chsecond: Character? = parseFirstChar() // May need to look ahead to determine this token

				switch chFirst {

				case ",":
					token = .commaToken
				case "(":
					token = .leftParenToken
				case ")":
					token = .rightParenToken
				case "{":
					token = .leftBraceToken
				case "}":
					token = .rightBraceToken
				case ".":
					token = .dotToken
				case ":":
					token = .colonToken
				case "[":
					token = .leftBracketToken
				case "]":
					token = .rightBracketToken
				case "@":
					token = .atToken
				case "^":
					token = .caretToken
				case "•":
					token = .dotToken
				case "≠":
					token = .NEToken
				case "*":
					token = .multiplyToken
				case "/", "÷":
					token = .divideToken
				case "%":
					token = .modToken
				case "≤":
					token = .LEToken
				case "≥":
					token = .GEToken

				case "+":
					if let chsecond = chsecond, chsecond == "+" {
						let _ = parsePopChar()!
						token = .plusplusToken
					}
					else {
						token = .addToken
					}

				case "-":
					if let chsecond = chsecond, chsecond == "-" {
						let _ = parsePopChar()!
						token = .minusminusToken
					}
					else {
						token = .subtractToken
					}

				case "=":
					if let chsecond = chsecond, chsecond == "=" {
						let _ = parsePopChar()!
						token = .EQToken
					}
					else {
						token = .assignToken
					}

				case "&":
					if let chsecond = chsecond, chsecond == "&" {
						let _ = parsePopChar()!
						token = .andandToken
					}
					else {
						token = .bitandToken
					}

				case "|":
					if let chsecond = chsecond, chsecond == "|" {
						let _ = parsePopChar()!
						token = .ororToken
					}
					else {
						token = .bitorToken
					}

				case "<":
					if let chsecond = chsecond, chsecond == "=" {
						let _ = parsePopChar()!
						token = .LEToken
					}
					else {
						token = .LTToken
					}

				case ">":
					if let chsecond = chsecond, chsecond == "=" {
						let _ = parsePopChar()!
						token = .GEToken
					}
					else {
						token = .GTToken
					}

				case "!":
					if let chsecond = chsecond, chsecond == "=" {
						let _ = parsePopChar()!
						token = .NEToken
					}
					else {
						token = .notToken
					}

				default:
					throw LangError(.illegalToken)
				}
			}
		}
		catch { throw error }

		guard let token = token else {
			throw LangError(.illegalToken)
		}

		return TokenWithPosition(token)
	}

	func parsePopIdentifier() -> String {

		/* Pull characters off the front of the input stream as long as
		we're still getting identifier characters. */

		var s = ""

		while true {

			guard let ch = parseFirstChar() else {
				return s
			}

			if !ch.isIdentifierChar() {
				return s
			}

			if let _ = parsePopChar() {
				s.append(ch)
			}
		}
	}

	func parsePopNumber() -> Value {

		/* Pull characters off the front of the input stream as long as
		we're still getting digits. When we hit the first non-digit,
		convert what we got into a long and return it.

		We expect at least one numeric digit to be there, and do not
		provide for an error return.

		5/29/91 dmb: support hex constants in the form "0xhhhhhhhh" */

		var isHex = false
		var isFloat = false
		var numberString = ""

		if parseFirstChar()! == "0" {  // check for hex constant

			let _ = parsePopChar()
			guard let ch = parseFirstChar() else {
				return 0 //TODO: error
			}
			if ch == "x" {
				let _ = parsePopChar()
				isHex = true
			}
		}

		while true {

			guard let ch = parseFirstChar() else {
				return 0
			}

			if ch == "." && isFloat {
				isFloat = true
			}
			else {
				if !ch.isDigit() && !(isHex && isxdigit(ch.asInt32()) != 0) {

					if isFloat {
						return (numberString as NSString).doubleValue
					}
					else if isHex {
						if let n = hexStringToNumber(numberString) {
							return n
						}
						return 0
					}
					else {
						if let n = stringToNumber(numberString) {
							return n
						}
						return 0
					}
				}
			}

			numberString.append(parsePopChar()!)
		}
	}

	func parsePopStringConst() throws -> String {

		/*
		Pop a string constant off the front of the input stream and return it.

		Throw an error if the string wasn't properly terminated.

		5/6/93: don't allow a string to span input lines

		2.1b2 dmb: handle escape sequences
		*/

		guard let chstart = parsePopChar() else { // Pop off opening doublequote
			throw LangError(.stringNotTerminated)
		}

		let savedPosition = textPosition

		let chstop = (chstart == openDoubleCurlyQuote) ? closeDoubleCurlyQuote : doubleQuote

		var s = ""

		func stringNotTerminatedError() -> LangError {
			// Make error message point at string start
			return LangError(.stringNotTerminated, textPosition: savedPosition)
		}

		while true {

			guard let ch = parsePopChar() else {
				throw stringNotTerminatedError()
			}

			if ch == chstop { // properly terminated string
				return s
			}

			if ch.isReturnOrLineFeed() { // don't allow string to span lines
				break
			}

			if ch == "\\" {
				if let unescapedCharacter = parsePopEscapeSequence() {
					s.append(unescapedCharacter)
				}
				else {
					throw stringNotTerminatedError()
				}
			}
			else {
				s.append(ch)
			}
		}

		throw stringNotTerminatedError()
	}

	func parseStringEmpty() -> Bool {

		return ixParseString == ixEndString
	}

	func parsePopCharConst() throws -> Value? {

		/*
		Pop a character constant in the form of '<char>' off the input stream. Return with error if there was no char following the first ' or if the character immediately following <char> is not another '.

		3/29/91 dmb: handle 4-character ostype constants as well 1-char.

		2.1b2 dmb: handle escape sequences

		2.1b6 dmb: see comment in parsepopstringconst; check for the end
		of the scan string before parsing escape sequences
		*/

		guard let _ = parsePopChar() else {  // Get rid of first single-quote
			return nil
		}

		let savedPosition = textPosition
		var len = 0
		var ch4 = ""

		func badConstError() -> LangError {

			return LangError(.badCharConst, textPosition: savedPosition)
		}

		while true {

			guard let ch = parsePopChar() else {
				throw badConstError()
			}

			if ch == singleQuote {

				if len == 1 { // Normal character const
					return ch.asInt()
				}
				else if len == 4 { // OSType character const
					return OSType(ch4)
				}
				else {
					throw badConstError()
				}
			}

			if len >= 4 {
				throw badConstError()
			}

			if ch == backslash {
				guard let unescapedCharacter = parsePopEscapeSequence() else {
					throw badConstError()
				}
				ch4.append(unescapedCharacter)
			}
			else {
				ch4.append(ch)
			}

			len = len + 1
		}
	}

	func parsePopEscapeSequence() -> Character? {

		/* 
		Get the next string character out of the input stream,
		i.e. a character that is part of a string or character constant.
		This is where we handle backslashes for special characters
		*/

		guard let ch = parsePopChar() else {
			return nil
		}

		switch ch {

		case "n":
			return lineFeed
		case "r":
			return carriageReturn
		case "t":
			return tab
		case backslash:
			return backslash
		case singleQuote:
			return singleQuote
		case doubleQuote:
			return doubleQuote
			//		case "x":
			//			return parseHexString() // TODO

		default:
			return ch
		}
	}

	//	func parseHexString() -> Int? {
	//
	//		guard let firstChar = parseFirstChar() else {
	//			return nil
	//		}
	//		if !isxdigit(firstChar.asInt()) {
	//			return 0
	//		}
	//
	//		let ch = parsePopChar()!
	//		let s = String(ch)
	//		if let secondChar = parseFirstChar() {
	//			let ch2 = parsePopChar()!
	//			s.append(ch2)
	//		}
	//
	//		return hexStringToNumber(s)
	//	}

	func parsePopChar() -> Character? {

		if parseStringEmpty() {
			return nil
		}

		ixParseString = parseString.index(after: ixParseString)
		textPosition = textPosition.nextCharacter()
		guard let ch = parseFirstChar() else {
			return nil
		}

		if lineBasedScan && ch.isReturnOrLineFeed() { // Passed over another line
			textPosition = textPosition.nextLine()
		}

		return ch
	}

	func parseFirstChar() -> Character? {

		// Return the character at the head of the parse stream without popping it.

		if parseStringEmpty() {
			return nil
		}

		return parseString[ixParseString]
	}

	func parseNextChar() -> Character? {

		// Return the next character at the head of the parse stream without popping it.

		if parseStringEmpty() {
			return nil
		}

		let ix = parseString.index(after: ixParseString)
		if ix == ixEndString {
			return nil
		}
		return parseString[ix]
	}

	func parsePopComment() {

		while true {

			guard let ch = parsePopChar() else {
				return
			}
			if ch == endComment || ch.isReturnOrLineFeed() {
				return
			}
		}
	}

	func parsePopBlanks() -> Bool {

		// Pop all the leading white space. Return false if the input stream is empty, true otherwise.

		while true {

			guard let ch = parseFirstChar() else {
				return false // End of string
			}

			var isStartComment = (ch == startComment) // Comments start with « or //
			if !isStartComment && ch == forwardSlash {
				if let chNext = parseNextChar(), chNext == forwardSlash {
					isStartComment = true
				}
			}

			if isStartComment {
				parsePopComment()
			}
			else {
				if !ch.isWhiteSpace() {
					return true
				}
				let _ = parsePopChar()  // Consume a whitespace character
			}
		}
	}
}

private let digitSet: Set<Character> = Set(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
private let alphaSet: Set<Character> = Set(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                                            "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                                            "u", "v", "w", "x", "y", "z",
                                            "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                                            "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                                            "U", "V", "W", "X", "Y", "Z"])
private extension Character {

	func isReturnOrLineFeed() -> Bool {

		return self == lineFeed || self == carriageReturn
	}

	func isWhiteSpace() -> Bool {

		return self == tab || self == space || isReturnOrLineFeed()
	}

	func asInt32() -> Int32 {

		let s = String(self)
		return Int32(s.utf8[s.utf8.startIndex])
	}

	func asInt() -> Int {

		let s = String(self)
		return Int(s.utf8[s.utf8.startIndex])
	}

	func isDigit() -> Bool {

		return digitSet.contains(self)
	}

	func isASCIIAlpha() -> Bool {

		return alphaSet.contains(self)
	}

	func isFirstIdentifier() -> Bool {

		return isASCIIAlpha() || self == "_"
	}

	func isIdentifierChar() -> Bool {

		// Could the character be the second through nth character in an identifier?

		if isFirstIdentifier() || isDigit() {
			return true
		}
		if self == "™" { // OrigFrontier: langscan.c:98 (I don’t know why)
			return true
		}
		return false
	}
}

private func hexStringToNumber(_ s: String) -> Int? {
	
	let scanner = Scanner(string: s)
	var n: UInt64 = 0
	if scanner.scanHexInt64(&n) {
		return Int(n)
	}
	return nil
}

private func stringToNumber(_ s: String) -> Int? {
	
	let scanner = Scanner(string: s)
	var n = 0
	if scanner.scanInt(&n) {
		return n
	}
	return nil
}

