//
//  artnet_appTests.swift
//  artnet-appTests
//
//  Created by Maegan Wilson on 2/11/19.
//  Copyright © 2019 MW. All rights reserved.
//

import XCTest

class artnet_appTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_calcSubnet_is_Zero() {
        let calc = Calculations()
        let subnet_and_universe = calc.calcSubUni(fixtureUniverse: 0)
        
        XCTAssertEqual(0, subnet_and_universe[0])
    }
    func test_calcUniverse_is_Zero() {
        let calc = Calculations()
        let subnet_and_universe = calc.calcSubUni(fixtureUniverse: 0)
        
        XCTAssertEqual(0, subnet_and_universe[1])
    }

}
