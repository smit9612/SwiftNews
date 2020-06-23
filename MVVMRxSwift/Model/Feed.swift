//
//  Feed.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation

struct Feed: ServiceCodable {

    var kind: String?
    var feedData: FeedData?

    enum CodingKeys: String, CodingKey {

        case kind
        case feedData = "data"
    }
}

struct FeedData: ServiceCodable {

    var modhash: String?
    var dist: Int?
    var children: [Child]?
    var after: String?
    var before: String?
}

struct Child: ServiceCodable {

    var kind: String?
    var childData: ChildData?

    enum CodingKeys: String, CodingKey {

        case kind
        case childData = "data"
    }
}

struct ChildData: ServiceCodable {
    var selftext: String?
    var authorFullName, Name: String?
    var thumbnail: String?
    var preview: Preview?
}

struct Preview: ServiceCodable {
    var images: [Image]?
    var enabled: Bool?
}

// MARK: - Image
struct Image: ServiceCodable {
    var source: ResizedIcon?
    var resolutions: [ResizedIcon]?
    var id: String?
}

// MARK: - ResizedIcon
struct ResizedIcon: ServiceCodable {
    var url: String?
    var width, height: Int?
}
