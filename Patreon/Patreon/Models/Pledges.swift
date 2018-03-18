//
//  Pledges.swift
//  Patreon
//
//  Created by Foti Dim on 17.03.18.
//  Copyright © 2018 FotiDim. All rights reserved.
//

public struct Pledges: Codable {
    struct Data: Codable {
        struct Attributes: Codable {
            let amountCents: Int
            let createdAt: Date
            let declinedSince: Date?
            let patronPaysFees: Bool
            let pledgeCapCents: Int?
            private enum CodingKeys: String, CodingKey {
                case amountCents = "amount_cents"
                case createdAt = "created_at"
                case declinedSince = "declined_since"
                case patronPaysFees = "patron_pays_fees"
                case pledgeCapCents = "pledge_cap_cents"
            }
        }
        let attributes: Attributes
        let id: String
        struct Relationships: Codable {
            struct Patron: Codable {
                struct Data: Codable {
                    let id: String
                    let type: String
                }
                let data: Data
                struct Links: Codable {
                    let related: URL
                }
                let links: Links
            }
            let patron: Patron
            struct Reward: Codable {
                struct Data: Codable {
                    let id: String
                    let type: String
                }
                let data: Data
                struct Links: Codable {
                    let related: URL
                }
                let links: Links
            }
            let reward: Reward?
        }
        let relationships: Relationships
        let type: String
    }
    let data: [Data]
    struct Included: Codable {
        struct Attributes: Codable {
            let about: String?
            let created: String?
            let email: String?
            let facebook: String?
            let firstName: String?
            let fullName: String?
            let gender: Int?
            let imageUrl: URL?
            let isEmailVerified: Bool?
            let lastName: String?
            struct SocialConnections: Codable {
                let deviantart: String?
                let discord: String?
                let facebook: String?
                let spotify: String?
                let twitch: String?
                let twitter: String?
                let youtube: String?
            }
            let socialConnections: SocialConnections?
            let thumbUrl: URL?
            let twitch: String?
            let twitter: String?
            let url: URL?
            let vanity: String?
            let youtube: String?
            let amountCents: Int?
            let createdAt: Date?
            let description: String?
            let discordRoleIds: [Int]?
            let editedAt: Date?
            let patronCount: Int?
            let postCount: Int?
            let published: Bool?
            let publishedAt: Date?
            let remaining: Int?
            let requiresShipping: Bool?
            let title: String?
            let unpublishedAt: String?
            let userLimit: Int?
            private enum CodingKeys: String, CodingKey {
                case about
                case created
                case email
                case facebook
                case firstName = "first_name"
                case fullName = "full_name"
                case gender
                case imageUrl = "image_url"
                case isEmailVerified = "is_email_verified"
                case lastName = "last_name"
                case socialConnections = "social_connections"
                case thumbUrl = "thumb_url"
                case twitch
                case twitter
                case url
                case vanity
                case youtube
                case amountCents = "amount_cents"
                case createdAt = "created_at"
                case description
                case discordRoleIds = "discord_role_ids"
                case editedAt = "edited_at"
                case patronCount = "patron_count"
                case postCount = "post_count"
                case published
                case publishedAt = "published_at"
                case remaining
                case requiresShipping = "requires_shipping"
                case title
                case unpublishedAt = "unpublished_at"
                case userLimit = "user_limit"
            }
        }
        let attributes: Attributes
        let id: String
        let type: String
    }
    let included: [Included]
    struct Links: Codable {
        let first: URL
        let next: URL?
    }
    let links: Links
    struct Meta: Codable {
        let count: Int
    }
    let meta: Meta
}
