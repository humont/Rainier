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

let emptyToken = 0
let EQToken = 400
let NEToken = 401
let GTToken = 402
let LTToken = 403
let GEToken = 404
let LEToken = 405
let notToken = 406
let andandToken = 407
let ororToken = 408
let beginswithToken = 409
let endswithToken = 410
let containsToken = 411
let bitandToken = 412
let bitorToken = 413
let loopToken = 500
let fileloopToken = 501
let inToken = 502
let breakToken = 503
let returnToken = 504
let ifToken = 505
let thenToken = 506
let elseToken = 507
let bundleToken = 508
let localToken = 509
let onToken = 510
let whileToken = 511
let caseToken = 512
let kernelToken = 513
let forToken = 514
let toToken = 515
let downtoToken = 516
let continueToken = 517
let withToken = 518
let tryToken = 519
let globalToken = 520
let errorToken = 292
let eolToken = 293
let constantToken = 294
let identifierToken = 295
let otherToken = 296
let assignToken = 297
let addToken = 298
let subtractToken = 299
let multiplyToken = 300
let divideToken = 301
let modToken = 302
let plusplusToken = 303
let minusminusToken = 304
let unaryminusToken = 305


// OrigFrontier: langscan.c

class Tokenizer {

	var sentEOL = false
	var ixParseString: String.Index
	let ixEndString: String.Index
	let parseString: String
	let lineBasedScan: Bool
	var ctScanLines = 0
	var ctScanCharacters = 0

	init(_ parseString: String, lineBasedScan: Bool) {

		self.parseString = parseString
		self.lineBasedScan = lineBasedScan
		self.ixParseString = parseString.startIndex
		self.ixEndString = parseString.endIndex
	}

	func parseGetToken(_ nodeToken: inout CodeTreeNode) -> Int {

		if parseStringEmpty() {
			return emptyToken
		}

		do {
			let token = try langScanner(&nodeToken)
			return token
		}
		catch { return emptyToken }
	}
}

private let singleQuote: Character = "'"
private let doubleQuote: Character = "\""
private let openDoubleCurlyQuote: Character = "”"
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

	func langScanner(_ nodeToken: inout CodeTreeNode) throws -> Int {

		/*Scan the input string for the next token, return the character
		that we stopped on in chtoken.

		If it's an identifier or a constant, the returned node will be non-nil.

		11/22/91 dmb: return zero when out of text, after returning exactly
		one (non-zero) eoltoken.
		*/

		if !parsePopBlanks() { /*ran out of text*/
			if sentEOL {
				return emptyToken
			}
			sentEOL = true
			return eolToken
		}

		let chFirst = parseFirstChar()!
		let ch = chFirst

		do {
			if ch == singleQuote { // A single-quote, character constant

				guard let val = try parsePopCharConst() else {
					return errorToken
				}
				nodeToken = newConstNode(val)
				return constantToken
			}

			if ch == doubleQuote || ch == openDoubleCurlyQuote { // A string constant

				let val = try parsePopStringConst()
				nodeToken = newConstNode(val)
				return constantToken
			}

			if ch.isDigit() {

				let val = parsePopNumber()
				nodeToken = newConstNode(val)
				return constantToken
			}

			if ch.isFirstIdentifier() {

				let identifier = parsePopIdentifier()
				
				if let keywordValue = Keywords.lookup(identifier) {
					return keywordValue
				}

				if let constantValue = Constants.lookup(identifier) {
					nodeToken = newConstNode(constantValue)
					return constantToken
				}

				nodeToken = newIdentifierNode(identifier)
				return identifierToken
			}

			let _ = parsePopChar() // Consume the token char
			let chsecond: Character? = parseFirstChar() // May need to look ahead to determine this token

			switch chFirst {

			case ",", "(", ")", ";", "{", "}", ".", ":", "[", "]", "@", "^":
				return chFirst.asInt() // The ascii value is the token

			case "•":
				return Character(".").asInt()

			case "≠":
				return NEToken

			case "*":
				return multiplyToken

			case "/", "÷":
				return divideToken

			case "%":
				return modToken

			case "≤":
				return LEToken

			case "≥":
				return GEToken

			case "+":
				if let chsecond = chsecond, chsecond == "+" {
					let _ = parsePopChar()!
					return plusplusToken
				}
				return addToken

			case "-":
				if let chsecond = chsecond, chsecond == "-" {
					let _ = parsePopChar()!
					return minusminusToken
				}
				return subtractToken

			case "=":
				if let chsecond = chsecond, chsecond == "=" {
					let _ = parsePopChar()!
					return EQToken
				}
				return assignToken

			case "&":
				if let chsecond = chsecond, chsecond == "&" {
					let _ = parsePopChar()!
					return andandToken
				}
				return bitandToken

			case "|":
				if let chsecond = chsecond, chsecond == "|" {
					let _ = parsePopChar()!
					return ororToken
				}
				return bitorToken

			case "<":
				if let chsecond = chsecond, chsecond == "=" {
					let _ = parsePopChar()!
					return LEToken
				}
				return LTToken

			case ">":
				if let chsecond = chsecond, chsecond == "=" {
					let _ = parsePopChar()!
					return GEToken
				}
				return GTToken

			case "!":
				if let chsecond = chsecond, chsecond == "=" {
					let _ = parsePopChar()!
					return NEToken
				}
				return notToken

			default:
				throw LangError(.illegalToken)
			}
		}
		catch { throw error }
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

		/* Pop a string constant off the front of the input stream and return it.

		Throw an error if the string wasn't properly terminated.

		5/6/93: don't allow a string to span input lines

		2.1b2 dmb: handle escape sequences */

		guard let chstart = parsePopChar() else { // Pop off opening doublequote
			throw LangError(.stringNotTerminated)
		}

		let lnum = ctScanLines
		let cnum = ctScanCharacters

		let chstop = (chstart == openDoubleCurlyQuote) ? closeDoubleCurlyQuote : doubleQuote

		var s = ""

		func stringNotTerminatedError() -> LangError {
			// Make error message point at string start
			return LangError(.stringNotTerminated, lineNumber: lnum, characterIndex: cnum)
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

		/* Pop a character constant in the form of '<char>' off the input stream. Return with error if there was no char following the first ' or if the character immediately following <char> is not another '.

		3/29/91 dmb: handle 4-character ostype constants as well 1-char.

		2.1b2 dmb: handle escape sequences

		2.1b6 dmb: see comment in parsepopstringconst; check for the end
		of the scan string before parsing escape sequences
		*/

		guard let _ = parsePopChar() else {  // Get rid of first single-quote
			return nil
		}

		var lnum = ctScanLines
		var cnum = ctScanCharacters
		var len = 0
		var ch4 = ""

		func badConstError() -> LangError {

			return LangError(.badCharConst, lineNumber: lnum, characterIndex: cnum)
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

		/* Get the next string character out of the input stream,
		i.e. a character that is part of a string or character constant.
		This is where we handle backslashes for special characters */

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
		ctScanCharacters = ctScanCharacters + 1 // For error reporting
		guard let ch = parseFirstChar() else {
			return nil
		}

		if lineBasedScan && ch.isReturnOrLineFeed() { // Passed over another line
			ctScanLines = ctScanLines + 1 // For error reporting
			ctScanCharacters = 0
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

