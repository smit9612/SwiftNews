//
//  RestaurantViewModelTests.swift
//  MVVMRxSwiftTests
//
//  Created by smitesh patel on 2020-06-22.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import MVVMRxSwift

class NewsViewModelTests: XCTestCase {

    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testfetchNewsViewModelsSuccess() {
        let disposeBag = DisposeBag()
        // Given a network Service sucess
        let networkService = NetworkService()
        networkService.setURLSession((MockURLSession(mockType: .success)))
        
        let viewModel = NewsListViewModel()
        let expectNormalRestaurantCellCreated = expectation(description: "restaurants contains a normal cell")
        // When fetchNewListView
        viewModel.fetchNewListViewModel().subscribe(
            onNext: {
                XCTAssertEqual($0.first?.displayText, "What Swift-related projects are you currently working on?")
                expectNormalRestaurantCellCreated.fulfill()
            }
        ).disposed(by: disposeBag)
        wait(for: [expectNormalRestaurantCellCreated], timeout: 5.0)
    }
    
//    func test_SelectNews_EmitsShowNews() {
//        var testChildData = ChildData()
//        let viewModel = NewsListViewModel()
//        testChildData.selftext = "test"
//        testChildData.thumbnail = "www.google.ca"
//        let testchild = Child(kind: "T3", childData: testChildData)
//        let newsToSelect = NewsViewModel(child: testchild)
//
//        let selectNewsObservable = testScheduler.createHotObservable([Recorded.next(300, newsToSelect)])
//
//        selectNewsObservable
//            .bind(to: viewModel.selectedNews)
//            .disposed(by: disposeBag)
//
//        let result = testScheduler.start { viewModel.showNews.map { $0.displayText } }
//        XCTAssertEqual(result.events, [Recorded.next(300, "test")])
//    }


}
