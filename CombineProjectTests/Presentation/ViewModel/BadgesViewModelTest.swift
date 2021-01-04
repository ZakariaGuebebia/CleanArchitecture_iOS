//
//  BadgesViewModelTest.swift
//  CombineProjectTests
//
//  Created by zakaria.guebebia on 27/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import XCTest
import Combine
@testable import CombineProject

class BadgesViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfully_getAllBadges() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let usecase = MockFetchBadgesUseCase(fetchBadgesUseCaseType: .success)
        usecase.successExpectation = expectation(description: "did load badges")
        let viewModel = DefaultBadgesViewModel(fetchBadgesUseCase: usecase)
        
        viewModel.loadBadges()
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFailuure_getAllBadges() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let usecase = MockFetchBadgesUseCase(fetchBadgesUseCaseType: .failure)
        usecase.failureExpectation = expectation(description: "error loading badges")
        let viewModel = DefaultBadgesViewModel(fetchBadgesUseCase: usecase)

        viewModel.loadBadges()
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
        
    }

}

enum FetchBadgesUseCaseType {
    case success
    case failure
}

class MockFetchBadgesUseCase: FetchBadgesUseCase {
    
    static let badgesArray = [Badge.stub(),
                       Badge.stub(),
                       Badge.stub(),
                       Badge.stub()]
    
    var successExpectation: XCTestExpectation?
    var failureExpectation: XCTestExpectation?
    
    var error: CPError?
    var fetchBadgesUseCaseType: FetchBadgesUseCaseType?
        
    internal init(fetchBadgesUseCaseType:FetchBadgesUseCaseType) {
        self.fetchBadgesUseCaseType = fetchBadgesUseCaseType
    }
    
    func execute() -> Future<(([BadgeDTO], [Badge])), Error> {
        
        let result : Future<(([BadgeDTO], [Badge])), Error>
        
        switch self.fetchBadgesUseCaseType {
        case .success:
            successExpectation?.fulfill()
            result = Future { promise in promise(.success((([], MockFetchBadgesUseCase.badgesArray))))}
        case .failure:
            failureExpectation?.fulfill()
            result = Future { promise in promise(.failure(CPError.init(errorCode: ErrorCodeType.genericError.rawValue)))}
        case .none:
            result = Future { promise in promise(.failure(CPError.init(errorCode: ErrorCodeType.genericError.rawValue)))}
        }
        
        return result
    }
}
