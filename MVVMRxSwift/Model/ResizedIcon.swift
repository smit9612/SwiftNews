// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resizedIcon = try? newJSONDecoder().decode(ResizedIcon.self, from: jsonData)

import Foundation

// MARK: - ResizedIcon
struct ResizedIcon: ServiceCodable {
    var url: String?
    var width, height: Int?
}
