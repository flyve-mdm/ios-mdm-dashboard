//
//  FlyveMDMAdminDashboardUITests.swift
//  FlyveMDMAdminDashboardUITests
//
//  Created by Hector Rondon on 27/06/18.
//  Copyright © 2018 Teclib. All rights reserved.
//

import XCTest

class FlyveMDMAdminDashboardUITests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        app.launchEnvironment = [ "UITest": "1" ]
        setupSnapshot(app)
        app.launch()
        sleep(1)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// This method take screenshots from fastlane snapshot
    func testTakeScreenshots() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
