//
//  ContentView.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 09/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: App.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var apps: FetchedResults<App>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(self.apps, id: \.self) { app in
                        Text(app.name ?? "")
                    }
                }
                Button("Add") {
                    let app = App(context: self.moc)
                    app.name = "Item \(self.apps.count)"

                    let price = Price(context: self.moc)
                    price.value = 10

                    app.addToPrices(price)
                    self.save()
                }

            }
            .navigationBarTitle("Wishlist")
//            .navigationBarItems(trailing: EditButton())
        }
    }

    func save() {
        try? self.moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
