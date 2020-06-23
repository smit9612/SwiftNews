// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let image = try? newJSONDecoder().decode(Image.self, from: jsonData)

import Foundation

// MARK: - Image
struct Image: ServiceCodable {
    var source: ResizedIcon?
    var resolutions: [ResizedIcon]?
    var variants: Gildings?
    var id: String?
}
