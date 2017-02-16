//
//  Repository.swift
//  Tentacle
//
//  Created by Matt Diephouse on 3/3/16.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation


/// A GitHub.com or GitHub Enterprise repository.
public struct Repository: Hashable, CustomStringConvertible {
    public let server: Server
    public let owner: String
    public let name: String
    
    public init(server: Server = .dotCom, owner: String, name: String) {
        self.server = server
        self.owner = owner
        self.name = name
    }
    
    /// The URL of the repository.
    public var url: URL {
        return server.url
            .appendingPathComponent(owner)
            .appendingPathComponent(name)
    }
    
    public var hashValue: Int {
        return description.lowercased().hashValue
    }
    
    public var description: String {
        return "\(url)"
    }
}

public func ==(lhs: Repository, rhs: Repository) -> Bool {
    return lhs.server == rhs.server
        && lhs.owner.caseInsensitiveCompare(rhs.owner) == .orderedSame
        && lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame
}
