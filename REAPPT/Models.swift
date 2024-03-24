import Foundation
struct UserProfile {
    var username: String
    var profileImageURL: URL?
    var bio: String
    var website: URL?
    var location: String
    var followersCount: Int
    var followingCount: Int
    var posts: [Post]
    var highlights: [Highlight]
    var notifications: [Notification]
    var isPrivate: Bool
}

struct Post: Identifiable {
    let id: UUID = UUID()
    var content: String
    var imageURL: URL
}

struct Highlight: Identifiable {
    let id: UUID = UUID()
    var coverImageURL: URL
    var stories: [Story]
}

struct Story: Identifiable {
    let id: UUID = UUID()
    var imageURL: URL
    var duration: TimeInterval
}

struct Notification: Identifiable {
    let id: UUID = UUID()
    var type: NotificationType
    var message: String
}

enum NotificationType {
    case follower
    case like
    case comment
}
