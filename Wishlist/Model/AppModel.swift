//
//  AppModel.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 13/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import CoreData
import Foundation

struct AppModel {
    var id: String
    var name: String
    var description: String = ""
    var url: URL
    var genre: String
    var kind: String
    var iconURL: URL
    var seller: String
    var bundleId: String
    
    var prices: [PriceModel]
    
    func toEntity(with moc: NSManagedObjectContext) -> AppEntity {
        let app = AppEntity(context: moc)
        app.id = id
        app.name = name
        app.desc = description
        app.url = url
        app.genre = genre
        app.kind = kind
        app.iconUrl = iconURL
        app.seller = seller
        app.bundleId = bundleId
        
        app.prices = NSSet(array: prices.map { $0.toEntity(with: moc) })
        return app
    }
}
