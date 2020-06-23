// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let childData = try? newJSONDecoder().decode(ChildData.self, from: jsonData)

import Foundation

// MARK: - ChildData
struct ChildData: ServiceCodable {
    var approvedAtUTC: JSONNull?
    var subreddit: Subreddit?
    var selftext, authorFullname: String?
    var saved: Bool?
    var modReasonTitle: JSONNull?
    var gilded: Int?
    var clicked: Bool?
    var title: String?
    var linkFlairRichtext: [JSONAny]?
    var subredditNamePrefixed: SubredditNamePrefixed?
    var hidden: Bool?
    var pwls: Int?
    var linkFlairCSSClass: String?
    var downs: Int?
    var thumbnailHeight: Int?
    var topAwardedType: JSONNull?
    var hideScore: Bool?
    var name: String?
    var quarantine: Bool?
    var linkFlairTextColor: FlairTextColor?
    var upvoteRatio: Double?
    var authorFlairBackgroundColor: String?
    var subredditType: SubredditType?
    var ups, totalAwardsReceived: Int?
    var mediaEmbed: Gildings?
    var thumbnailWidth: Int?
    var authorFlairTemplateID: JSONNull?
    var isOriginalContent: Bool?
    var userReports: [JSONAny]?
    var secureMedia: JSONNull?
    var isRedditMediaDomain, isMeta: Bool?
    var category: JSONNull?
    var secureMediaEmbed: Gildings?
    var linkFlairText: String?
    var canModPost: Bool?
    var score: Int?
    var approvedBy: JSONNull?
    var authorPremium: Bool?
    var thumbnail: String?
    var edited: Edited?
    var authorFlairCSSClass: JSONNull?
    var authorFlairRichtext: [JSONAny]?
    var gildings: Gildings?
    var contentCategories: JSONNull?
    var isSelf: Bool?
    var modNote: JSONNull?
    var created: Int?
    var linkFlairType: FlairType?
    var wls: Int?
    var removedByCategory, bannedBy: JSONNull?
    var authorFlairType: FlairType?
    var domain: Domain?
    var allowLiveComments: Bool?
    var selftextHTML: String?
    var likes: JSONNull?
    var suggestedSort: String?
    var bannedAtUTC, viewCount: JSONNull?
    var archived, noFollow, isCrosspostable, pinned: Bool?
    var over18: Bool?
    var allAwardings: [AllAwarding]?
    var awarders: [JSONAny]?
    var mediaOnly, canGild, spoiler, locked: Bool?
    var authorFlairText: String?
    var treatmentTags: [JSONAny]?
    var visited: Bool?
    var removedBy, numReports: JSONNull?
    var distinguished: String?
    var subredditID: SubredditID?
    var modReasonBy, removalReason: JSONNull?
    var linkFlairBackgroundColor, id: String?
    var isRobotIndexable: Bool?
    var reportReasons: JSONNull?
    var author: String?
    var discussionType: String?
    var numComments: Int?
    var sendReplies: Bool?
    var whitelistStatus: WhitelistStatus?
    var contestMode: Bool?
    var modReports: [JSONAny]?
    var authorPatreonFlair: Bool?
    var authorFlairTextColor: FlairTextColor?
    var permalink: String?
    var parentWhitelistStatus: WhitelistStatus?
    var stickied: Bool?
    var url: String?
    var subredditSubscribers, createdUTC, numCrossposts: Int?
    var media: JSONNull?
    var isVideo: Bool?
    var postHint: String?
    var preview: Preview?
    var linkFlairTemplateID: String?
    var mediaMetadata: MediaMetadata?

    enum CodingKeys: String, CodingKey {
        case approvedAtUTC
        case subreddit, selftext
        case authorFullname
        case saved
        case modReasonTitle
        case gilded, clicked, title
        case linkFlairRichtext
        case subredditNamePrefixed
        case hidden, pwls
        case linkFlairCSSClass
        case downs
        case thumbnailHeight
        case topAwardedType
        case hideScore
        case name, quarantine
        case linkFlairTextColor
        case upvoteRatio
        case authorFlairBackgroundColor
        case subredditType
        case ups
        case totalAwardsReceived
        case mediaEmbed
        case thumbnailWidth
        case authorFlairTemplateID
        case isOriginalContent
        case userReports
        case secureMedia
        case isRedditMediaDomain
        case isMeta
        case category
        case secureMediaEmbed
        case linkFlairText
        case canModPost
        case score
        case approvedBy
        case authorPremium
        case thumbnail, edited
        case authorFlairCSSClass
        case authorFlairRichtext
        case gildings
        case contentCategories
        case isSelf
        case modNote
        case created
        case linkFlairType
        case wls
        case removedByCategory
        case bannedBy
        case authorFlairType
        case domain
        case allowLiveComments
        case selftextHTML
        case likes
        case suggestedSort
        case bannedAtUTC
        case viewCount
        case archived
        case noFollow
        case isCrosspostable
        case pinned
        case over18
        case allAwardings
        case awarders
        case mediaOnly
        case canGild
        case spoiler, locked
        case authorFlairText
        case treatmentTags
        case visited
        case removedBy
        case numReports
        case distinguished
        case subredditID
        case modReasonBy
        case removalReason
        case linkFlairBackgroundColor
        case id
        case isRobotIndexable
        case reportReasons
        case author
        case discussionType
        case numComments
        case sendReplies
        case whitelistStatus
        case contestMode
        case modReports
        case authorPatreonFlair
        case authorFlairTextColor
        case permalink
        case parentWhitelistStatus
        case stickied, url
        case subredditSubscribers
        case createdUTC
        case numCrossposts
        case media
        case isVideo
        case postHint
        case preview
        case linkFlairTemplateID
        case mediaMetadata
    }
}
