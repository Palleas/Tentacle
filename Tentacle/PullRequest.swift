//
//  PullRequest.swift
//  Tentacle
//
//  Created by Romain Pouclet on 2016-05-23.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct PullRequest: Hashable, CustomStringConvertible {
    /// The URL to view the Pull Request is an browser
    public let URL: NSURL

    /// The URL to the diff showing all the changes included in this pull request
    public let diffURL: NSURL

    /// The URL to a downloadable patch for this pull request
    public let patchURL: NSURL

    public var hashValue: Int {
        return URL.hashValue
    }

    public var description: String {
        #if swift(>=2.3)
            return URL.absoluteString!
        #else
            return URL.absoluteString
        #endif
    }
}

public func ==(lhs: PullRequest, rhs: PullRequest) -> Bool {
    return lhs.URL == rhs.URL
}

extension PullRequest: ResourceType {
    public static func decode(j: JSON) -> Decoded<PullRequest> {
        return curry(self.init)
            <^> (j <| "html_url" >>- toNSURL)
            <*> (j <| "diff_url" >>- toNSURL)
            <*> (j <| "patch_url" >>- toNSURL)

    }
}
