// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let allAwarding = try? newJSONDecoder().decode(AllAwarding.self, from: jsonData)

import Foundation

// MARK: - AllAwarding
struct AllAwarding: ServiceCodable {
    var giverCoinReward: Int?
    var subredditID: JSONNull?
    var isNew: Bool?
    var daysOfDripExtension, coinPrice: Int?
    var id: String?
    var pennyDonate: Int?
    var awardSubType: String?
    var coinReward: Int?
    var iconURL: String?
    var daysOfPremium: Int?
    var resizedIcons: [ResizedIcon]?
    var iconWidth, staticIconWidth: Int?
    var startDate: JSONNull?
    var isEnabled: Bool?
    var allAwardingDescription: String?
    var endDate: JSONNull?
    var subredditCoinReward, count, staticIconHeight: Int?
    var name: String?
    var resizedStaticIcons: [ResizedIcon]?
    var iconFormat: String?
    var iconHeight, pennyPrice: Int?
    var awardType: String?
    var staticIconURL: String?

    enum CodingKeys: String, CodingKey {
        case giverCoinReward
        case subredditID
        case isNew
        case daysOfDripExtension
        case coinPrice
        case id
        case pennyDonate
        case awardSubType
        case coinReward
        case iconURL
        case daysOfPremium
        case resizedIcons
        case iconWidth
        case staticIconWidth
        case startDate
        case isEnabled
        case allAwardingDescription
        case endDate
        case subredditCoinReward
        case count
        case staticIconHeight
        case name
        case resizedStaticIcons
        case iconFormat
        case iconHeight
        case pennyPrice
        case awardType
        case staticIconURL
    }
}
