//
//  CodeTreeNode.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/20/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

public final class CodeTreeNode: NSObject {
	
	public let nodeType: Int
	public var value: Value?
	public var lineNumber: Int?
	public var characterIndex: Int?
	public var prevLink: CodeTreeNode?
	public var link: CodeTreeNode?
	public var param1: CodeTreeNode?
	public var param2: CodeTreeNode?
	public var param3: CodeTreeNode?
	public var param4: CodeTreeNode?

	public var ctParams: Int {
		get {
			var ct = 0
			if let _ = param1 {
				ct = ct + 1
			}
			else if let _ = param2 {
				ct = ct + 1
			}
			else if let _ = param3 {
				ct = ct + 1
			}
			else if let _ = param4 {
				ct = ct + 1
			}
			return ct
		}
	}

	public init(nodeType: Int, value: Value?, lineNumber: Int?, characterIndex: Int?, link: CodeTreeNode?, param1: CodeTreeNode?, param2: CodeTreeNode?, param3: CodeTreeNode?, param4: CodeTreeNode?) {
		
		self.nodeType = nodeType
		self.value = value
		self.lineNumber = lineNumber
		self.characterIndex = characterIndex
		self.link = link
		
		self.param1 = param1
		self.param2 = param2
		self.param3 = param3
		self.param4 = param4
		
		super.init()
	}

	public convenience init(nodeType: CodeTreeNodeType) {
		
		self.init(nodeType: nodeType, value: nil, lineNumber: nil, characterIndex: nil, link: nil, param1: nil, param2: nil, param3: nil, param4: nil)
	}

	public convenience init(nodeType: CodeTreeNodeType, value: Value) {

		self.init(nodeType: nodeType, value: value, lineNumber: nil, characterIndex: nil, link: nil, param1: nil, param2: nil, param3: nil, param4: nil)
	}

	public convenience init(nodeType: CodeTreeNodeType, takingValueFromNode otherNode: CodeTreeNode) {
		
		// node.value is inaccessible from Objective-C, hence this trick.
		self.init(nodeType: nodeType, value: otherNode.value, lineNumber: nil, characterIndex: nil, link: nil, param1: nil, param2: nil, param3: nil, param4: nil)
	}

	public convenience init(nodeType: CodeTreeNodeType, param1: CodeTreeNode?, param2: CodeTreeNode?, param3: CodeTreeNode?, param4: CodeTreeNode?) {
		
		self.init(nodeType: nodeType, value: nil, lineNumber: nil, characterIndex: nil, link: nil, param1: param1, param2: param2, param3: param3, param4: param4)
	}

}


func valueNode(_ nodeType: Int, _ value: Value) -> CodeTreeNode {

	return CodeTreeNode(nodeType: nodeType, value: value)
}

func newConstNode(_ value: Value) -> CodeTreeNode {

	return valueNode(constOp, value)
}

func newIdentifierNode(_ value: Value) -> CodeTreeNode {

	return valueNode(identifierOp, value)
}
