//
//  CodeTreeNode.m
//  UserTalk
//
//  Created by Brent Simmons on 4/30/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

#import "CodeTreeNode.h"
#import "UserTalk-Swift.h"

// PBS 30 April 2017: This provides a bridge between the generated-by-bison parser,
// which is C code, and CodeTreeNode, which is Swift.
//
// These C interfaces are the same as they are in OrigFrontier because it
// allows me to touch langparser.y the least amount possible.

void pushunaryoperation(CodeTreeType type, CodeTreeNode *param1, CodeTreeNode **newNode) {

	*newNode = [CodeTreeNode nodeWithNodeType:type param1:param1];
}

void pushbinaryoperation(CodeTreeType type, CodeTreeNode *param1, CodeTreeNode *param2, CodeTreeNode **newNode) {

	*newNode = [CodeTreeNode nodeWithNodeType:type param1:param1 param2:param2];
}

void pushoperation(CodeTreeType type, CodeTreeNode **newNode) {

	*newNode = [CodeTreeNode nodeWithNodeType:type];
}

void pushlastlink(CodeTreeNode *newLast, CodeTreeNode *list) {

	/*
	newlast is a newly parsed object, for example a statement in a statement
	list or a parameter expression in a parameter list.

	tack it on at the end of the list headed up by hlist. we travel from
	list until we hit nil, then backup and insert newlast as the last node
	in the list.

	the link field of the CodeTreeNode is used to connect the list.

	12/9/91 dmb: don't treat nil newlast as an error
	*/

	if (!newLast || !list) {
		return;
	}

	CodeTreeNode *nomad = list;

	while(true) {

		if (!nomad.link) {
			nomad.link = newLast;
			NSCAssert(newList.link == nil || newLast.nodeType == fieldOp);
			return
		}
		nomad = nomad.link;
	}
}

boolean pushtripletstatementlists(CodeTreeNode *p2, CodeTreeNode *p3, CodeTreeNode *list) {

	/*
	add the statement lists to the previously-created triplet.

	the triplet was created earlier so that the line/character position
	information could be meaningful.

	since the triplet was created with unassigned parameters set to
	nil, we only set non-nil parameters.  this is more than an optimization;
	it adds flexibility so that for some callers (like fileloop), one
	of these parameters can already be set
	*/

	if (p2) {
		list.param2 = p2
	}
	if (p3) {
		list.param3 = p3
	}
}

void pushunarystatementlist(CodeTreeNode *p1, CodeTreeNode *list) {

	list.param1 = p1
}

void pushloopbody(CodeTreeNode *p4, CodeTreeNode *list) {

	list.param4 = hp4;
}

void pushkernelcall(CodeTreeNode *node, CodeTreeNode **newNode) {

	*newNode = [CodeTreeNode nodeWithNodeType:kernelop value:node.value];
}

void pushtriplet(CodeTreeNodeType nodeType, CodeTreeNode *p1, CodeTreeNode *p2, CodeTreeNode *p3, CodeTreeNode **newNode) {

	*newNode = [CodeTreeNode nodeWithType:nodeType param1:p1 param2:p2 param3:p3];
}

void pushquadruplet (CodeTreeNodeType nodeType, CodeTreeNode *p1, CodeTreeNode *p2, CodeTreeNode *p3, CodeTreeNode *p4, CodeTreeNode **newNode) {

	*newNode = [CodeTreeNode nodeWithType:nodeType param1:p1 param2:p2 param3:p3 param4:p4];
}

void pushloop(CodeTreeNode *p1, CodeTreeNode *p2, CodeTreeNode *p3, CodeTreeNode **newNode) {

	pushquadruplet(loopop, p1, p2, p3, nil, newNode);
}



