//
//  langparser.h
//  UserTalk
//
//  Created by Brent Simmons on 4/30/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

#ifndef langparser_h
#define langparser_h

#import <UserTalk/UserTalk-Swift.h>

// OrigFrontier: langparser.h

#define YYSTYPE CodeTreeNode /*data type of yacc stack*/

extern CodeTreeNode *yylval;
extern CodeTreeNode *yyval;

#define tokentype NSInteger /*something that's returned by parsegettoken*/


/*prototypes*/

NSInteger yyparse(void); // langparser.c

//void parsesetscanstring(Handle, boolean); // langscan.c

unsigned long parsegetscanoffset(unsigned long, unsigned short);

void parsesetscanoffset(unsigned long);

tokentype parsegettoken(CodeTreeNode *);


#endif /* langparser_h */
