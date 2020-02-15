//
//  Mock.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 14/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

class Mock {
    static let shared = Mock()

    var apps: [AppModel] = [
        AppModel(id: "", name: "Blox", description: "", url: URL(string: "https://apps.apple.com/us/app/blox-the-game-of-blocks/id1470664581?uo=4")!, genre: "", kind: "", iconURL: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Purple113/v4/66/ea/0f/66ea0fb7-dfee-5d13-c2ec-7e6bec4318de/source/512x512bb.jpg")!, seller: "", bundleId: "", prices: [])
    ]

    var app: AppModel { apps.first! }

    private init() {}
}
