//
//  NutrikuTest.swift
//  NutrikuTests
//
//  Created by Syamsul Falah on 20/09/19.
//  Copyright © 2019 Falah. All rights reserved.
//

import XCTest
@testable import Nutriku

class NutrikuTest: XCTestCase {

    let detailFood = DetailFoodVC()
    
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
    
    func testGetEnergyPoint() {
        let result = detailFood.getEnergyPoint(energyValue: 219)
        XCTAssertEqual(result, 2)
    }
    
    func testGetSugarPoint() {
        let result = detailFood.getSugarPoint(sugarValue: 7)
        XCTAssertEqual(result, 1)
    }
    
    func testSfaPoint() {
        let result = detailFood.getSfaPoint(sfaValue: 4.5)
        XCTAssertEqual(result, 4)
    }
    
    func testSodiumPoint() {
        let result = detailFood.getSodiumPoint(sodiumValue: 185)
        XCTAssertEqual(result, 2)
    }
    
    
}
