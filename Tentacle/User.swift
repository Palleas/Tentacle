//
//  User.swift
//  Tentacle
//
//  Created by Matt Diephouse on 4/12/16.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Argo
import Curry

/// A User on GitHub.
public struct User: Hashable, CustomStringConvertible {
    /// The unique ID of the user.
    public let ID: String
    
    /// The user's login/username.
    public let login: String
    
    /// The URL of the user's GitHub page.
    public let URL: NSURL
    
    /// The URL of the user's avatar.
    public let avatarURL: NSURL
    
    public var hashValue: Int {
        return ID.hashValue
    }
    
    public var description: String {
        return login
    }
    
    public init(ID: String, login: String, URL: NSURL, avatarURL: NSURL) {
        self.ID = ID
        self.login = login
        self.URL = URL
        self.avatarURL = avatarURL
    }
}

public func ==(lhs: User, rhs: User) -> Bool {
    return lhs.ID == rhs.ID
        && lhs.login == rhs.login
        && lhs.URL == rhs.URL
        && lhs.avatarURL == rhs.avatarURL
}

extension User: ResourceType {
    public static func decode(j: JSON) -> Decoded<User> {
        return curry(self.init)
            <^> (j <| "id" >>- toString)
            <*> j <| "login"
            <*> j <| "html_url"
            <*> j <| "avatar_url"
    }
}

/// Extended information about a user on GitHub.
public struct UserInfo {
    /// The user that this information refers to.
    public let user: User
    
    /// The date that the user joined GitHub.
    public let joinedDate: NSDate
    
    /// The user's name if they've set one.
    public let name: String?
    
    /// The user's public email address if they've set one.
    public let email: String?
    
    /// The URL of the user's website if they've set one
    public let websiteURL: NSURL?
    
    /// The user's company if they've set one.
    public let company: String?
    
    public var hashValue: Int {
        return user.hashValue
    }
    
    public var description: String {
        return user.description
    }
    
    public init(user: User, joinedDate: NSDate, name: String?, email: String?, websiteURL: NSURL?, company: String?) {
        self.user = user
        self.joinedDate = joinedDate
        self.name = name
        self.email = email
        self.websiteURL = websiteURL
        self.company = company
    }
}

public func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
    return lhs.user == rhs.user
        && lhs.joinedDate == rhs.joinedDate
        && lhs.name == rhs.name
        && lhs.email == rhs.email
        && lhs.websiteURL == rhs.websiteURL
        && lhs.company == rhs.company
}

extension UserInfo: ResourceType {
    public static func decode(j: JSON) -> Decoded<UserInfo> {
        return curry(self.init)
            <^> j <| []
            <*> (j <| "created_at" >>- toNSDate)
            <*> j <|? "name"
            <*> j <|? "email"
            <*> j <|? "blog"
            <*> j <|? "company"
    }
}
