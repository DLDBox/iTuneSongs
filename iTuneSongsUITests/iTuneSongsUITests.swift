//
//  iTuneSongsUITests.swift
//  iTuneSongsUITests
//
//  Created by Dana Devoe on 5/18/20.
//  Copyright © 2020 Dana Devoe. All rights reserved.
//

import XCTest
import iTuneSongs

class iTuneSongsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAlert() throws {
        let app = XCUIApplication()
        app.launch()
        
        
        let exception = expectation(description: "Wait for test to complete")
        
        let alert = UIAlertController( title:"This is a test ", message: "Please connect to the internet", preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            
        }))
        
        alert.showNow()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: {
            alert.hideNow()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                exception.fulfill()
            })
        })
        
        self.waitForExpectations(timeout: 20, handler: nil)

    }
    


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
