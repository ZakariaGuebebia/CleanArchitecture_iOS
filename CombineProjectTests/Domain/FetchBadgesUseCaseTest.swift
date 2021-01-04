//
//  FetchBadgesUseCaseTest.swift
//  CombineProjectTests
//
//  Created by zakaria.guebebia on 26/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import XCTest
import Combine
@testable import CombineProject

class FetchBadgesUseCaseTest: XCTestCase {
    
    static let badgesArray = [Badge.stub(),
                       Badge.stub(),
                       Badge.stub(),
                       Badge.stub()]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// test FetchBadgesUseCase with success
    func testFetchBadgesUseCaseTest_whenSuccessfullyFetchesBadges() {
        
        let repository = MockBadgeRepository(mockedDataSource: SuccessMockedBadgesDataSource())
        let useCase = DefaultFetchBadgesUseCase(badgeRepository: repository)

        let expectation = self.expectation(description: "Fetching Badges with Success")
        
        let stateHandler : StateHandler = { (result) in
            switch result {
            case .finished:
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        // When start fetch
        DispatchQueue.main.asyncAfter(deadline: (.now() + 1)) {
            useCase.execute().sink(receiveCompletion: stateHandler, receiveValue: { (_,_) in }).store(in: &cancellable)
        }
        // Wait for the expectation to be fullfilled, or time out
        // after 2 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 2, handler: nil)
        
    }
    /// test FetchBadgesUseCase with Error
    func testFetchBadgesUseCaseTest_whenFailedFetchingBadges() {
        
        let repository = MockBadgeRepository(mockedDataSource: FailureMockedBadgesDataSource())
        let useCase = DefaultFetchBadgesUseCase(badgeRepository: repository)

        let expectation = self.expectation(description: "Fetching Badges with Error")
        
        let stateHandler : StateHandler = { (result) in
            switch result {
            case .finished:
                break
            case .failure(let error):
                XCTAssertEqual((error as! CPError).statusCode, ErrorCodeType.genericError.rawValue,"Generic Error")
                expectation.fulfill()
            }
        }
        // When start fetch
        DispatchQueue.main.asyncAfter(deadline: (.now() + 1)) {
            useCase.execute().sink(receiveCompletion: stateHandler, receiveValue: { (_,_) in }).store(in: &cancellable)
        }
        // Wait for the expectation to be fullfilled, or time out
        // after 2 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 2, handler: nil)
        
    }

}
class MockBadgeRepository : BadgeRepository {
    
    internal init(mockedDataSource: BadgesDataSource) {
        self.mockedDataSource = mockedDataSource
    }
    private let mockedDataSource: BadgesDataSource
    
    func getAllbadges() -> Future<(([BadgeDTO], [Badge])), Error> {
        mockedDataSource.getAllbadges()
    }
    
}

class SuccessMockedBadgesDataSource: BadgesDataSource {
    
    func getAllbadges() -> Future<(([BadgeDTO], [Badge])), Error> {
        return Future { promise in promise(.success((([], FetchBadgesUseCaseTest.badgesArray))))}
    }
}
class FailureMockedBadgesDataSource: BadgesDataSource {

    func getAllbadges() -> Future<(([BadgeDTO], [Badge])), Error> {
        return  Future { promise in promise(.failure(CPError.init(errorCode: ErrorCodeType.genericError.rawValue)))}
    }
}
