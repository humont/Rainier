//
//  Keywords.swift
//  UserTalk
//
//  Created by Brent Simmons on 4/29/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import FrontierData

// OrigFrontier: langtokens.h

let appleeventfunc = 1
let complexeventfunc = 2
let findereventfunc = 3
let tableeventfunc = 4
let objspecfunc = 5
let setobjspecfunc = 6
let packfunc = 7
let unpackfunc = 8
let definedfunc = 9
let typeoffunc = 10
let sizeoffunc = 11
let nameoffunc = 12
let parentoffunc = 13
let indexoffunc = 14
let gestaltfunc = 15
let syscrashfunc = 16
let myMooffunc = 17

// Below must agree with numbers in langparser.y

let equalsfunc = 400
let notequalsfunc = 401
let greaterthanfunc = 402
let lessthanfunc = 403
let greaterthanorequalfunc = 404
let lessthanorequalfunc = 405
let notfunc = 406
let andfunc = 407
let orfunc = 408
let beginswithfunc = 409
let endswithfunc = 410
let containsfunc = 411
let loopfunc = 500
let fileloopfunc = 501
let infunc = 502
let breakfunc = 503
let returnfunc = 504
let iffunc = 505
let thenfunc = 506
let elsefunc = 507
let bundlefunc = 508
let localfunc = 509
let onfunc = 510
let whilefunc = 511
let casefunc = 512
let kernelfunc = 513
let forfunc = 514
let tofunc = 515
let downtofunc = 516
let continuefunc = 517
let withfunc = 518
let tryfunc = 519
let globalfunc = 520


// OrigFrontier: langstartup.c

struct Keywords {

	static let keywordTable: HashTable = {

		let t = HashTable("keywords", Tables.languageTable)

		t.add("equals", equalsfunc)
		t.add("notequals", notequalsfunc)
		t.add("greaterthan", greaterthanfunc)
		t.add("lessthan", lessthanfunc)
		t.add("not", notfunc)
		t.add("and", andfunc)
		t.add("or", orfunc)
		t.add("beginswith", beginswithfunc)
		t.add("endswith", endswithfunc)
		t.add("contains", containsfunc)
		t.add("loop", loopfunc)
		t.add("fileloop", fileloopfunc)
		t.add("while", whilefunc)
		t.add("in", infunc)
		t.add("break", breakfunc)
		t.add("continue", continuefunc)
		t.add("return", returnfunc)
		t.add("if", iffunc)
		t.add("then", thenfunc)
		t.add("else", elsefunc)
		t.add("bundle", bundlefunc)
		t.add("local", localfunc)
		t.add("on", onfunc)
		t.add("case", casefunc)
		t.add("kernel", kernelfunc)
		t.add("for", forfunc)
		t.add("to", tofunc)
		t.add("downto", downtofunc)
		t.add("with", withfunc)
		t.add("try", tryfunc)

		t.isReadOnly = true
		
		return t
	}()

	static func lookup(_ identifier: String) -> Int? {

		return keywordTable.lookup(identifier) as? Int
	}
}
