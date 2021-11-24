//
//  ExtensionTest.swift
//  shortcut code challenge UIKitTests
//
//  Created by Mohsen on 11/23/21.
//

import XCTest
@testable import shortcut_code_challenge_UIKit

class ExtensionTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckEqualDate() throws {
        
        let dateFormatter = ISO8601DateFormatter()
        let localObj = dateFormatter.date(from: "1990-02-19T00:00:00+0000")
        
        let convertedDate = Date.convertToDate("1990", "02", "19")
        
        XCTAssertEqual(localObj, convertedDate)
        
        
    }
    
    func testCheckDateWithOnlyYear() throws {
        let dateFormatter = ISO8601DateFormatter()
        let localObj = dateFormatter.date(from: "1990-01-01T00:00:00+0000")
        
        let convertedDate = Date.convertToDate("1990")
        
        XCTAssertEqual(localObj, convertedDate)
    }
    
    func testIsNilArray() throws {
        
        let obj = [1,2]
        
        XCTAssertEqual(obj[safe: 2], nil)
    }
   
    func testConvertToLongDate() throws {
        
        var date = Date.convertToDate("1990", "02", "19")
        
        let strLongDate = date!.convertToLongDate()
        
        XCTAssertEqual(strLongDate, "Feb 19,1990")
    }
  

  

}
