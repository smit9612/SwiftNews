// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let feedData = try? newJSONDecoder().decode(FeedData.self, from: jsonData)

import Foundation

// MARK: - FeedData
struct FeedData: ServiceCodable {
    var modhash: String?
    var dist: Int?
    var children: [Child]?
    var after: String?
    var before: JSONNull?
}
