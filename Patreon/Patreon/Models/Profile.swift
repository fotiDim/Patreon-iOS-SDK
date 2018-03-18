//
//  Profile.swift
//  Patreon
//
//  Created by Foti Dim on 17.03.18.
//  Copyright © 2018 FotiDim. All rights reserved.
//

public struct Profile: Codable {
    struct Data: Codable {
        struct Attributes: Codable {
            let about: String?
            let created: String
            let discordId: String?
            let email: String
            let facebook: URL?
            let facebookId: String?
            let firstName: String
            let fullName: String
            let gender: Int
            let hasPassword: Bool
            let imageUrl: URL
            let isDeleted: Bool
            let isEmailVerified: Bool
            let isNuked: Bool
            let isSuspended: Bool
            let lastName: String
            struct SocialConnections: Codable {
                let deviantart: String?
                let discord: String?
                let facebook: String?
                let spotify: String?
                let twitch: String?
                let twitter: String?
                let youtube: String?
            }
            let socialConnections: SocialConnections
            let thumbUrl: URL
            let twitch: String?
            let twitter: String?
            let url: URL
            let vanity: String
            let youtube: String?
            private enum CodingKeys: String, CodingKey {
                case about
                case created
                case discordId = "discord_id"
                case email
                case facebook
                case facebookId = "facebook_id"
                case firstName = "first_name"
                case fullName = "full_name"
                case gender
                case hasPassword = "has_password"
                case imageUrl = "image_url"
                case isDeleted = "is_deleted"
                case isEmailVerified = "is_email_verified"
                case isNuked = "is_nuked"
                case isSuspended = "is_suspended"
                case lastName = "last_name"
                case socialConnections = "social_connections"
                case thumbUrl = "thumb_url"
                case twitch
                case twitter
                case url
                case vanity
                case youtube
            }
        }
        let attributes: Attributes
        let id: String
        struct Relationships: Codable {
            struct Pledges: Codable {
                let data: [Pledges]
            }
            let pledges: Pledges
        }
        let relationships: Relationships
        let type: String
    }
    let data: Data
    struct Links: Codable {
        let `self`: URL
    }
    let links: Links
}

