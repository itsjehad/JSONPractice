//
//  JSONPracticeTests.swift
//  JSONPracticeTests
//
//  Created by Jehad Sarkar on 2019-10-24.
//  Copyright © 2019 itsjehad. All rights reserved.
//

import XCTest
@testable import JSONPractice

class JSONPracticeTests: XCTestCase {

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
    
    func testNewsAPIData(){
        let queryParams = QueryParams("ca", "science")
        let request = NewsAPI.newsListAPI(queryParams)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url, URL(string: "https://newsapi.org/v2/top-headlines"))
        let retQueryParams = try? JSONDecoder().decode(QueryParams.self, from: request.httpBody!)
        XCTAssertEqual(retQueryParams?.category, queryParams.category)
        XCTAssertEqual(retQueryParams?.country, queryParams.country)
        XCTAssertEqual(retQueryParams?.apiKey, queryParams.apiKey)
        
    }
    func testNewsAPIRequest(){
        let queryParams = QueryParams("ca", "science")
        let request = NewsAPI.newsListAPI(queryParams)
        let expectation = self.expectation(description: "Downloading data")
        RetrieveJSON.getResponse(request, { articles in
            print(articles)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
        
    }

}
