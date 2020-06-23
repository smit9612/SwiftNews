//
//  NewsFeedModelUnitTest.swift
//  MVVMRxSwiftTests
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import XCTest
@testable import MVVMRxSwift

class NewsModelUnitTest: XCTestCase {
    
    func testNewsModelThumbnail() {
        // Give an news
        var child = Child()
        child.kind = "t3"
        
        var childData = ChildData()
        
        // Given a newsFeedModel with empty child
        child.childData = childData
        var newsModel = NewsViewModel(child: child)
        // Then imagURL will nil
        XCTAssertNil(newsModel.imageURL)
        
        // when childData has thumbnail self
        childData.thumbnail = "self"
        child.childData = childData
        newsModel.child = child
        // Then imageURL will not be nill
        XCTAssertNil(newsModel.imageURL)
    
        // when childData has thumbnail
        childData.thumbnail = "www.google.ca"
        child.childData = childData
        newsModel.child = child
        newsModel = NewsViewModel(child: child)
        // Then imageURL will not be nill
        XCTAssertNotNil(newsModel.imageURL)
    }
    
    func testNewsModelDisplayText() {
        
        //TODO test Unit test.
    }

}
