//
//  TestEqualityBool.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/22/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import XCTest
import FrontierData

class TestEqualityBool: XCTestCase {

    func testBoolEquality() {
 
		XCTAssertTrue(try! true.equals(true))
		XCTAssertTrue(try! false.equals(false))
	}
	
	func testBoolInequality() {
		
		XCTAssertFalse(try! true.equals(false))
		XCTAssertFalse(try! false.equals(true))
	}
	
	func testBoolIntEquality() {
		
		XCTAssertTrue(try! true.asInt().equals(1))
		XCTAssertTrue(try! false.asInt().equals(0))
	}
	
	func testBoolIntInequality() {
		
		XCTAssertFalse(try! false.asInt().equals(1))
		XCTAssertFalse(try! true.asInt().equals(0))
	}
	
	func testBoolDoubleEquality() {
		
		XCTAssertTrue(try! true.asDouble().equals(1.0))
		XCTAssertTrue(try! false.asDouble().equals(0.0))
	}
	
	func testBoolDateEquality() {
		
		XCTAssertTrue(try! true.asDate().equals(Date(timeIntervalSince1904: 1.0)))
		XCTAssertTrue(try! false.asDate().equals(Date(timeIntervalSince1904: 0.0)))
	}
	
	func testBoolDirectionEquality() {
		
		let up = try! true.asDirection()
		XCTAssertTrue(try! up.equals(Direction.up))

		let noDirection = try! false.asDirection()
		XCTAssertTrue(try! noDirection.equals(Direction.noDirection))
	}
	
	func testBoolStringEquality() {
		
		XCTAssertTrue(try! true.asString().equals("true"))
		XCTAssertTrue(try! false.asString().equals("false"))
	}
	
	func testBoolListEquality() {
		
		let listFalse = List(value: false)
		let listTrue = List(value: true)
		XCTAssertTrue(try! true.asList().equals(listTrue))
		XCTAssertTrue(try! false.asList().equals(listFalse))
	}
}

