// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let preview = try? newJSONDecoder().decode(Preview.self, from: jsonData)

import Foundation

// MARK: - Preview
struct Preview: ServiceCodable {
    var images: [Image]?
    var enabled: Bool?
}
