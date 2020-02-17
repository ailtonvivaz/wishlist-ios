//
//  CoreStack.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 16/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import CoreData

class CoreStack {
    static var shared = CoreStack()

    private(set) var container: NSPersistentCloudKitContainer
    var moc: NSManagedObjectContext { container.viewContext }

    private init() {
        let container = NSPersistentCloudKitContainer(name: "Wishlist")

        let storeURL = URL.storeURL(for: "group.com.veevaz.Wishlist", databaseName: "Wishlist")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)

        if !container.persistentStoreDescriptions.contains(storeDescription) {
            container.persistentStoreDescriptions.append(storeDescription)
        }

        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        try? container.viewContext.setQueryGenerationFrom(.current)

        self.container = container
    }
}
