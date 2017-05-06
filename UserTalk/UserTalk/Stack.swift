//
//  Stack.swift
//  UserTalk
//
//  Created by Brent Simmons on 5/6/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

final class Stack {

	// Each scope gets a stack.
	// Stacks are actually a tree structure:
	// A single frame may have multiple children.
	// However: a frame knows its parent, but not its children.

	var frames = [StackFrame]()
	var currentFrame: StackFrame? {
		get {
			if frames.isEmpty {
				return nil
			}
			return frames.last
		}
	}

	func push(_ node: CodeTreeNode) -> StackFrame {

		let frame = StackFrame(node, currentFrame)
		frames += [frame]
	}

}
