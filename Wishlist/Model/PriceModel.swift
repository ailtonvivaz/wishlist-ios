//
//  PriceModel.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 15/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import CoreData

struct PriceModel {
    var date: Date
    var value: Float
    
    func toEntity(with moc: NSManagedObjectContext) -> Price {
        let price = Price(context: moc)
        price.date = date
        price.value = value
        return price
    }
}
