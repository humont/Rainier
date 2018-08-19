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
	let tokensWithPosition: [TokenWithPosition]
	var currentTokenIndex = 0
	var ctLoops = 0

	var insideLoop: Bool {
		get {
			return ctLoops > 0
		}
	}

	var currentTokenWithPosition: TokenWithPosition {
		get {
			return tokensWithPosition[currentTokenIndex]
		}
	}

	var currentToken: Token {
		get {
			return tokenAtIndex(currentTokenIndex)
		}
	}

	var currentTextPosition: TextPosition {
		get {
			return currentTokenWithPosition.position
		}
	}

	init(_ tokensWithPosition: [TokenWithPosition]) {

		assert(!tokensWithPosition.isEmpty)
		self.tokensWithPosition = tokensWithPosition
	}

	static func errorWithToken(_ token: TokenWithPosition, _ error: LangErrorType) -> LangError {
		
		return LangError(error, textPosition: token.position)
	}
	
	static func illegalTokenError(_ token: TokenWithPosition) -> LangError {
	
		return errorWithToken(token, .illegalToken)
	}

	func illegalTokenError() -> LangError {

		return Parser.illegalTokenError(currentTokenWithPosition)
	}

	func tokenAtIndex(_ ix: Int) -> Token? {

		if ix >= tokensWithPosition.count {
			return nil
		}
		return tokensWithPosition[ix].token
	}

	func popToken() -> Token? {

		if currentTokenIndex + 1 >= tokens.count {
			return nil
		}
		currentTokenIndex = currentTokenIndex + 1
		return currentToken
	}

	func peekNextToken() -> Token? {
		
		return tokenAtIndex(currentTokenIndex + 1)
	}

	func peekNextTokenIs(_ token: Token) -> Bool {
		
		guard let nextToken = peekNextToken() else {
			return false
		}
		return nextToken == token
	}

	func peekPreviousToken() -> Token? {

		if currentTokenIndex < 1 {
			return nil
		}
		return tokenAtIndex(currentTokenIndex - 1)
	}

	func peekPreviousTokenIs(_ token: Token) -> Bool {

		guard let previousToken = peekPreviousToken() else {
			return false
		}
		return previousToken == token
	}

	func parseNextToken() throws -> Bool {

		// Returns false when finished.

		guard let token = popToken() else {
			return false
		}

		do {
			if currentTokenIsAtBeginningOfStatement() {

				switch(token.type) {

				case breakOp:
					try parseBreak()
				}
			}
		}
		catch { throw error }

		return true
	}

	func parseConstant() {

		
	}

	func parseBlock() throws -> CodeTreeNode {

		

	}
	
	func parseBreak() throws {

		pushSimpleOperation(.breakOp)
		do {
			try skipEmptyParensIfNeeded() // break() is allowed in OrigFrontier
			try advanceToBeginningOfNextStatement()
		}
		catch { throw error }
	}

	func parseReturn() throws {

		let returnTextPosition = textPosition
		let expressionNode = try parseExpressionUntilEndOfStatement()
		pushUnaryOperation(.returnOp, returnTextPosition, expressionNode)
	}

	func parseExpressionUntilEndOfStatement() throws -> CodeTreeNode {

		guard let token = popToken() else {
			return 
		}

	}

	func currentTokenIsAtBeginningOfStatement() {

		if currentTokenIndex < 1 {
			return true
		}
		let previousToken = peekPreviousToken()!
		return previousToken.isEndOfStatement()
	}

	func skipEmptyParensIfNeeded() throws {
		
		if !peekNextTokenIs(.leftParenToken) {
			return
		}
		popToken()
		if !peekNextTokenIs(.rightParenToken) {
			throw illegalTokenError()
		}
		
		popToken()
	}

	func advanceToEndOfStatement() throws {

		guard let token = popToken() else {
			return
		}
		if token != .semicolonToken {
			throw illegalTokenError()
		}
	}

	func pushUnaryOperation(_ operation: CodeTreeNodeType, _ textPosition: TextPosition, _ expressionNode: CodeTreeNode) {

		let node = UnaryOperationNode(.returnOp, textPosition, expressionNode)
		push(node)
	}

	func pushSimpleOperation(_ operation: CodeTreeNodeType) {

		let operationNode = SimpleOperationNode(operation, currentTextPosition)
		pushNode(operationNode)
	}

	func push(_ node: CodeTreeNode) {

		currentNode.link = node
		node.prevLink = currentNode
		currentNode = node
	}
}

private extension Token {

	func isEndOfStatement() -> Bool {

		return self == .semicolonToken
	}
}

