//
//  Keywords.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/29/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// system.compiler.language.keywords
// OrigFrontier: langstartup.c

struct Keywords {

	static let keywordTable: HashTable = {

		let t = HashTable("keywords", Tables.languageTable)

		func addToken(_ name: String, _ token: Token) {

			t.add(name, token.rawValue)
		}

		addToken("equals", .EQToken)
		addToken("notequals", .NEToken)
		addToken("greaterthan", .GTToken)
		addToken("lessthan", .LTToken)
		addToken("not", .notToken)
		addToken("and", .andandToken)
		addToken("or", .ororToken)
		addToken("beginswith", .beginswithToken)
		addToken("endswith", .endswithToken)
		addToken("contains", .containsToken)
		addToken("loop", .loopToken)
		addToken("fileloop", .fileloopToken)
		addToken("while", .whileToken)
		addToken("in", .inToken)
		addToken("break", .breakToken)
		addToken("continue", .continueToken)
		addToken("return", .returnToken)
		addToken("if", .ifToken)
		addToken("then", .thenToken)
		addToken("else", .elseToken)
		addToken("bundle", .bundleToken)
		addToken("local", .localToken)
		addToken("on", .onToken)
		addToken("case", .caseToken)
		addToken("kernel", .kernelToken)
		addToken("for", .forToken)
		addToken("to", .toToken)
		addToken("downto", .downtoToken)
		addToken("with", .withToken)
		addToken("try", .tryToken)

		t.isReadOnly = true
		
		return t
	}()

	static func lookup(_ identifier: String) -> Token? {

		guard let n = keywordTable.lookup(identifier) as Integer else {
			return nil
		}
		return Token(rawValue: n)
	}
}

