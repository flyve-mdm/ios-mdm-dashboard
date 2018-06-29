/*
 * LICENSE
 *
 * FlyveMDMAdminDashboardUITests.swift is part of FlyveMDMAdminDashboard
 *
 * FlyveMDMAdminDashboard is a subproject of Flyve MDM. Flyve MDM is a mobile
 * device management software.
 *
 * FlyveMDMAdminDashboard is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 *
 * FlyveMDMAdminDashboard is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * ------------------------------------------------------------------------------
 * @author    Hector Rondon <hrondon@teclib.com>
 * @copyright Copyright © Teclib. All rights reserved.
 * @license   LGPLv3 https://www.gnu.org/licenses/lgpl-3.0.html
 * @link      https://github.com/flyve-mdm/ios-mdm-dashboard.git
 * @link      http://flyve.org/ios-mdm-dashboard
 * @link      https://flyve-mdm.com
 * ------------------------------------------------------------------------------
 */

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
