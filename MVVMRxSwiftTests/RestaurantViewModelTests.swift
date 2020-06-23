//
//  RestaurantViewModelTests.swift
//  MVVMRxSwiftTests
//
//  Created by smitesh patel on 2020-06-22.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import XCTest
import RxSwift

@testable import MVVMRxSwift

class RestaurantViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testfetchRestaurantViewModelsSuccess() {
        let disposeBag = DisposeBag()
        ManagerInjector.restaurantService = MockResaurantService()
        
        let viewModel = RestaurantListViewModel()
        

        let expectNormalRestaurantCellCreated = expectation(description: "restaurants contains a normal cell")
        
        viewModel.fetchRestaurantViewModels().subscribe(
            onNext: {
                XCTAssertEqual($0.first?.displayText, "Mock Rest1 - european")
                expectNormalRestaurantCellCreated.fulfill()
            }
        ).disposed(by: disposeBag)
        wait(for: [expectNormalRestaurantCellCreated], timeout: 5.0)
    }

}
