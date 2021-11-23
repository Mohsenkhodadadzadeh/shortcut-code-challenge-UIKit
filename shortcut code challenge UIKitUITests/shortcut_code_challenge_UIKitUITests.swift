//
//  shortcut_code_challenge_UIKitUITests.swift
//  shortcut code challenge UIKitUITests
//
//  Created by Mohsen on 11/23/21.
//

import XCTest

class shortcut_code_challenge_UIKitUITests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
    
    override func setUp() {
        continueAfterFailure = false
        
        XCUIApplication().launch()
    }

//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    override class func tearDown() {
        
    }
    
    func testCheckIsARowLoaded() throws {
        let occamCell = XCUIApplication().tables.staticTexts["Occam"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: occamCell, handler: nil)
        
        waitForExpectations(timeout: 8, handler: nil)
        
        XCTAssertTrue(occamCell.exists)
                                                        
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
