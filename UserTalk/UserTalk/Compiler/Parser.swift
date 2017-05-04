//
//  Parser.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/2/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

struct Parser {

	var currentNode = CodeTreeNode(nodeType: moduleOp)
	let tokens: [TokenWithPosition]
	var currentTokenIndex = 0
	var ctLoops = 0

	var insideLoop: Bool {
		get {
			return ctLoops > 0
		}
	}

	var currentToken: TokenWithPosition {
		get {
			return tokens[currentTokenIndex]
		}
	}

	init(_ tokens: [TokenWithPosition]) {

		assert(!tokens.isEmpty)
		self.tokens = tokens
	}

	func errorWithToken(_ token: TokenWithPosition, _ error: LangErrorType) -> LangError {
		
		return LangError(error, textPosition: token.position)
	}
	
	func illegalTokenError(_ token: TokenWithPosition) -> LangError {
	
		return errorWithToken(token, .illegalToken)
	}
	
	func currentToken() -> TokenWithPosition {

		return tokens[currentTokenIndex]
	}

	func popToken() -> TokenWithPosition? {

		if currentTokenIndex + 1 >= tokens.count {
			return nil
		}
		currentTokenIndex = currentTokenIndex + 1
		return currentToken()
	}

	func peekNextToken() -> TokenWithPosition? {
		
		if currentTokenIndex + 1 >= tokens.count {
			return nil
		}
		return tokens[currentTokenIndex + 1]
	}

	func peekNextTokenIs(_ token: TokenWithPosition) -> Bool {
		
		guard let nextToken = peekNextToken() else {
			return false
		}
		return nextToken == token
	}
	
	func parseToken(token: ParseToken) throws {
		
		switch(token.type) {
			
		case breakOp:
			parseBreak()
		}
		
	}

	func parseConstant() {

		
	}
	
	func parseBreak() throws {
		
		pushOperation(breakOp)
		do {
			try skipEmptyParensIfNeeded()
		}
		catch { throw error }
	}
	
	func skipEmptyParensIfNeeded() throws {
		
		if !peekNextTokenIs(.leftParenToken) {
			return
		}
		popToken()
		if !peekNextTokenIs(.rightParenToken) {
			throw illegalTokenError(currentToken)
		}
		
		popToken()
	}
	
	func pushOperation(_ operation: CodeTreeNodeType) {
		
		let operationNode = CodeTreeNode(nodeType: operation)
		currentNode.link = operationNode
		currentNode = operationNode
	}

	func pushNode(_ node: CodeTreeNodeType) {

		currentNode.link = node
		currentNode = node
	}
}
