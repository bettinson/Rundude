//
//  TimeConverterTests.swift
//  TimeConverterTests
//
//  Created by Matt Bettinson on 2016-07-06.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import XCTest

class TimeConverterTests: XCTestCase {
    
    let testFormatter = TimeFormatter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMinuteConversion() {
        //Should convert to "10:00"
        let testMinutesString = "1000"
        let newString = testFormatter.changeText(testMinutesString)
        
        print ("\(newString)")
        XCTAssertEqual(newString, "10:00")
    }
    
    func testHoursConversion() {
        //Should convert to "1:10:00"
        let testHoursString = "11000"
        let hourString = testFormatter.changeText(testHoursString)
        
        print ("\(hourString)")
        XCTAssertEqual(hourString, "1:10:00")
        
        let testTenHoursString = "101000"
        let tenHoursString = testFormatter.changeText(testTenHoursString)
        XCTAssertEqual(tenHoursString, "10:10:00")
        
    }
    
    func testIncremementalChange() {
        var iterativeString = "1"
        var iterativeComparator = testFormatter.changeText(iterativeString)
        
        XCTAssertEqual(iterativeComparator, "1")
        
        iterativeString = "10"
        iterativeComparator = testFormatter.changeText(iterativeString)
        
        XCTAssertEqual(iterativeComparator, "10")
        
        iterativeString = "100"
        iterativeComparator = testFormatter.changeText(iterativeString)
        
        XCTAssertEqual(iterativeComparator, "1:00")
        
        iterativeString = "1000"
        iterativeComparator = testFormatter.changeText(iterativeString)
        
        XCTAssertEqual(iterativeComparator, "10:00")
        
        iterativeString = "10001"
        iterativeComparator = testFormatter.changeText(iterativeString)
        
        XCTAssertEqual(iterativeComparator, "1:00:01")
        
        iterativeString = "100001"
        iterativeComparator = testFormatter.changeText(iterativeString)
        
        XCTAssertEqual(iterativeComparator, "10:00:01")
    }
    
    func testRandom() {
        let iterativeString = "3456"
        let iterativeComparator = testFormatter.changeText(iterativeString)
        
        XCTAssertEqual(iterativeComparator, "34:56")
    }
    
    func testShouldDoNothing() {
        let seconds = "10"
        let newString = testFormatter.changeText(seconds)
        
        XCTAssertEqual(seconds, newString)
    }
}
