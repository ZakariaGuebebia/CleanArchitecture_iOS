//
//  Badge+Stub.swift
//  CombineProjectTests
//
//  Created by zakaria.guebebia on 26/11/2020.
//  Copyright © 2020 zakaria.guebebia. All rights reserved.
//

import Foundation
@testable import CombineProject

extension Badge {
    static func stub(name: String? = "Best Friend",
                      photo: String? = "https://csb065e1ed02c47x44dcx855.blob.core.windows.net/fintunecontentcontainer/87b5a209-2f4d-401c-bdb5-2149016aa28f.png",
                      id: String? = "8a748030750e2dcb01750e3bb52f0004",
                      type: BadgeType? = .bestFriend) -> Badge {
        return Badge(
            name: name,
            photo: photo,
            id: id,
            type: type)
    }
}
