// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let child = try? newJSONDecoder().decode(Child.self, from: jsonData)

import Foundation

// MARK: - Child
struct Child: ServiceCodable {
    var kind: Kind?
    var data: ChildData?
}
