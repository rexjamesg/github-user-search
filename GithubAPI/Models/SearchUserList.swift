// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchUserList = try? JSONDecoder().decode(SearchUserList.self, from: jsonData)

import Foundation

// MARK: - SearchUserList
struct SearchUserList: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [SearchUserListItem]?
}

extension SearchUserList {
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
        incompleteResults = try container.decodeIfPresent(Bool.self, forKey: .incompleteResults)
        items = try container.decodeIfPresent([SearchUserListItem].self, forKey: .items)
    }
}

// MARK: - SearchUserList
struct SearchUserListItem: Codable, Hashable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type, userViewType: String?
    let siteAdmin: Bool?
    let score: Int?
}

extension SearchUserListItem {
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "noed_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "receivedEvents_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
        case score
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        login = try container.decodeIfPresent(String.self, forKey: .login)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        nodeID = try container.decodeIfPresent(String.self, forKey: .nodeID)
        avatarURL = try container.decodeIfPresent(String.self, forKey: .avatarURL)
        gravatarID = try container.decodeIfPresent(String.self, forKey: .gravatarID)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        htmlURL = try container.decodeIfPresent(String.self, forKey: .htmlURL)
        followersURL = try container.decodeIfPresent(String.self, forKey: .followersURL)
        followingURL = try container.decodeIfPresent(String.self, forKey: .followingURL)
        gistsURL = try container.decodeIfPresent(String.self, forKey: .gistsURL)
        starredURL = try container.decodeIfPresent(String.self, forKey: .starredURL)
        subscriptionsURL = try container.decodeIfPresent(String.self, forKey: .subscriptionsURL)
        organizationsURL = try container.decodeIfPresent(String.self, forKey: .organizationsURL)
        reposURL = try container.decodeIfPresent(String.self, forKey: .reposURL)
        eventsURL = try container.decodeIfPresent(String.self, forKey: .eventsURL)
        receivedEventsURL = try container.decodeIfPresent(String.self, forKey: .receivedEventsURL)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        userViewType = try container.decodeIfPresent(String.self, forKey: .userViewType)
        siteAdmin = try container.decodeIfPresent(Bool.self, forKey: .siteAdmin)
        score = try container.decodeIfPresent(Int.self, forKey: .score)
    }
}
