//
//  URL+Extension.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 16/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

public extension URL {

    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
