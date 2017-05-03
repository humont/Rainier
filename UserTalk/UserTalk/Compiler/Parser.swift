//
//  Parser.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/2/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation


struct Parser {

	var currentNode = CodeTreeNode(nodeType: moduleOp)
	let tokens: [Integer]
	var currentTokenIndex = 0
	var ctLoops = 0

	var insideLoop: Bool {
		get {
			return ctLoops > 0
		}
	}

	var currentToken: Integer {
		get {
			return tokens[currentTokenIndex]
		}
	}

	init(_ tokens: [Integer]) {

		assert(!tokens.isEmpty)
		self.tokens = tokens
	}

	func currentToken() -> Integer {

		return tokens[currentTokenIndex]
	}

	func popToken() -> Integer? {

		if currentTokenIndex + 1 >= tokens.count {
			return nil
		}
		currentTokenIndex = currentTokenIndex + 1
		return currentToken()
	}

	func peekNextToken() -> Integer? {
		
		if currentTokenIndex + 1 >= tokens.count {
			return nil
		}
		return tokens[currentTokenIndex + 1]
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
		
		if !insideLoop {
			throw LangError(.illegalToken)
		}
		pushOperation(breakOp)
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
