//
//  HomeAPIUnitTests.swift
//  ExerciseTests
//
//  Created by Ankush Mahajan on 11/04/22.
//

import XCTest
@testable import Exercise

class HomeAPIUnitTests: XCTestCase {

    func testHomeAPIResponse() {
        
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "HomeAPIResponse")
        
        viewModel.blockHomeDataLoaded = {
            
            XCTAssertNil(viewModel.errorString)
            XCTAssertNotNil(viewModel.homeData)
            XCTAssertGreaterThan(viewModel.arrayHomeCollectionCellVM?.count ?? 0, 0)
            
            // Test case will fail as Title, Description, Image URl is null at some places in API Response
            // Comment below asserts to pass test
            XCTAssertNil(viewModel.arrayHomeCollectionCellVM?.first(where: {$0.homeDataModel?.title == nil}))
            XCTAssertNil(viewModel.arrayHomeCollectionCellVM?.first(where: {$0.homeDataModel?.description == nil}))
            XCTAssertNil(viewModel.arrayHomeCollectionCellVM?.first(where: {$0.homeDataModel?.imageHref == nil}))
            
            expectation.fulfill()
        }
        viewModel.getData()
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }

}
