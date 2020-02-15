//
//  Model.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 11/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

class Model: ObservableObject {
//    @Enviroment var context
    @Published var apps: [App] = []

    init() {
        
    }
}
