//
//  ZaloraAssignmentTests.swift
//  ZaloraAssignmentTests
//
//  Created by Thanh Tran on 9/21/17.
//  Copyright © 2017 Thanh. All rights reserved.
//

import XCTest
import Firebase

@testable import ZaloraAssignment

class ZaloraAssignmentTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let testString = "Hi, how is your life ?"
      XCTAssertNotNil(testString.split())
      
    }
  func testSplitFunctionOnePost(){
  
    let testString = "I love building internet product!"
    XCTAssertNotNil(testString.split())
    XCTAssertEqual(testString.split().count, 1, "User wrote more than 50 chars")
  }
  
  func testSplitFunctionMultiPost(){
    
    let testString = "I love building internet product! Creating a new tech-unicorn is awesome"
    XCTAssertNotNil(testString.split())
    
    XCTAssertGreaterThan(testString.split().count, 1, "User wrote less than 50 chars")
  }
  
  func testCharCountIfOnlyOnePost() {
    let testString = "I love building internet product! "
    XCTAssertNotNil(testString.split())
    
    XCTAssertEqual(testString.split().count, 1, "User wrote more than 50 chars")
  }
  
  func testCharCountIfMultiPost() {
    let testString = "I love building internet product! Creating a new tech-unicorn is awesome"
    XCTAssertNotNil(testString.split())
    
    XCTAssertGreaterThan(testString.split().count, 1, "User wrote less than 50 chars")
  }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
