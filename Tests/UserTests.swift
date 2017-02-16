//
//  UserTests.swift
//  Tentacle
//
//  Created by Matt Diephouse on 4/12/16.
//  Copyright © 2016 Matt Diephouse. All rights reserved.
//

import Argo
@testable import Tentacle
import XCTest

class UserTests: XCTestCase {
    func testDecodeMdiep() {
        let expected = UserInfo(
            user: User(
                ID: "1302",
                login: "mdiep",
                URL: NSURL(string: "https://github.com/mdiep")!,
                avatarURL: NSURL(string: "https://avatars.githubusercontent.com/u/1302?v=3")!
            ),
            joinedDate: NSDate(timeIntervalSince1970: 1204155107),
            name: "Matt Diephouse",
            email: "matt@diephouse.com",
            websiteURL: NSURL(string: "http://matt.diephouse.com"),
            company: nil
        )
        XCTAssertEqual(Fixture.UserInfo.mdiep.decode(), expected)
    }
    
    func testDecodeTest() {
        let expected = UserInfo(
            user: User(
                ID: "383316",
                login: "test",
                URL: NSURL(string: "https://github.com/test")!,
                avatarURL: NSURL(string: "https://avatars.githubusercontent.com/u/383316?v=3")!
            ),
            joinedDate: NSDate(timeIntervalSince1970: 1283337552),
            name: nil,
            email: nil,
            websiteURL: nil,
            company: nil
        )
        XCTAssertEqual(Fixture.UserInfo.test.decode(), expected)
    }
}
