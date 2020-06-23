// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let prydssay0A651 = try? newJSONDecoder().decode(Prydssay0A651.self, from: jsonData)

import Foundation

// MARK: - Prydssay0A651
struct Prydssay0A651: ServiceCodable {
    var status, e: String?
    var dashURL: String?
    var x, y: Int?
    var hlsURL: String?
    var id: String?
    var isGIF: Bool?

    enum CodingKeys: String, CodingKey {
        case status, e
        case dashURL
        case x, y
        case hlsURL
        case id
        case isGIF
    }
}
