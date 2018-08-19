//
//  Compiler.h
//  UserTalk
//
//  Created by Brent Simmons on 4/30/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

@import Foundation;

// OrigFrontier: langparser.h

@class CodeTreeNode;

#define YYSTYPE CodeTreeNode* /*data type of yacc stack*/

extern CodeTreeNode *yylval;
extern CodeTreeNode *yyval;

#define tokentype NSInteger /*something that's returned by parsegettoken*/


/*prototypes*/

//NSInteger yyparse(void); // langparser.c

//void parsesetscanstring(Handle, boolean); // langscan.c

//unsigned long parsegetscanoffset(unsigned long, unsigned short);
//
//void parsesetscanoffset(unsigned long);
//
//tokentype parsegettoken(CodeTreeNode *);

CodeTreeNode *pushquadruplet (NSInteger nodeType, CodeTreeNode *p1, CodeTreeNode *p2, CodeTreeNode *p3, CodeTreeNode *p4);
CodeTreeNode *pushoperation(NSInteger type);
CodeTreeNode *pushunaryoperation(NSInteger type, CodeTreeNode *param1);
CodeTreeNode *pushbinaryoperation(NSInteger type, CodeTreeNode *param1, CodeTreeNode *param2);
void pushlastlink(CodeTreeNode *newLast, CodeTreeNode *list);
void pushtripletstatementlists(CodeTreeNode *p2, CodeTreeNode *p3, CodeTreeNode *list);
void pushunarystatementlist(CodeTreeNode *p1, CodeTreeNode *list);
void pushloopbody(CodeTreeNode *p4, CodeTreeNode *list);
CodeTreeNode *pushkernelcall(CodeTreeNode *node);
CodeTreeNode *pushtriplet(NSInteger nodeType, CodeTreeNode *p1, CodeTreeNode *p2, CodeTreeNode *p3);
CodeTreeNode *pushloop(CodeTreeNode *p1, CodeTreeNode *p2, CodeTreeNode *p3);
