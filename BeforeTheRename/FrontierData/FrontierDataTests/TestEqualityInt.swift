//
//  TestEqualityInt.swift
//  FrontierData
//
//  Created by Brent Simmons on 4/22/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import XCTest
import FrontierData

class TestEqualityInt: XCTestCase {

	func testIntDoubleEquality() {
		
		XCTAssertTrue(try! 0.asDouble().equals(Double(0.0)))
		XCTAssertTrue(try! 1.asDouble().equals(Double(1.0)))
		XCTAssertTrue(try! 1_000_000.asDouble().equals(Double(1_000_000.0)))
		XCTAssertTrue(try! 938_843.asDouble().equals(Double(938_843.0)))
	}

	func testIntDateEquality() {
		
		let ints: [Int] = [0, 1, 3948, 3458997234789, 25807435, 23958, -239, -239823483337]
		for oneInt in ints {
			let oneDate = Date(timeIntervalSince1904: TimeInterval(oneInt))
			XCTAssertTrue(try! oneInt.asDate().equals(oneDate))
		}
	}
	
	func testIntDirectionEquality() {
		
		XCTAssertTrue(try! 0.asDirection().equals(Direction.noDirection))
		XCTAssertTrue(try! 1.asDirection().equals(Direction.up))
		XCTAssertTrue(try! 2.asDirection().equals(Direction.down))
		XCTAssertTrue(try! 3.asDirection().equals(Direction.left))
		XCTAssertTrue(try! 4.asDirection().equals(Direction.right))
		XCTAssertTrue(try! 5.asDirection().equals(Direction.flatUp))
		XCTAssertTrue(try! 6.asDirection().equals(Direction.flatDown))
		XCTAssertTrue(try! 8.asDirection().equals(Direction.sorted))
		XCTAssertTrue(try! 9.asDirection().equals(Direction.pageUp))
		XCTAssertTrue(try! 10.asDirection().equals(Direction.pageDown))
		XCTAssertTrue(try! 11.asDirection().equals(Direction.pageLeft))
		XCTAssertTrue(try! 12.asDirection().equals(Direction.pageRight))
	}
	
	func testIntStringEquality() {
		
		let ints: [Int] = [0, 1, 3948, 3458997234789, 25807435, 23958, -239, -239823483337]
		for oneInt in ints {
			let oneString = "\(oneInt)"
			XCTAssertTrue(try! oneInt.asString().equals(oneString))
		}
	}
}
