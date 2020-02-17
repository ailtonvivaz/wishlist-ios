//
//  HomePageView.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 09/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import CoreData
import SwiftUI

struct HomePageView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: AppEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var apps: FetchedResults<AppEntity>

    @State private var showingSheet = false

    var body: some View {
        GeometryReader { _ in
            NavigationView {
                Form {
                    ForEach(self.apps, id: \.id) { app in
                        NavigationLink(destination: AppPageView(app: app)) {
                            AppCellView(app: app)
                        }
                    }
                }
                .navigationBarTitle("Wishlist")
            }
        }
    }

    func save() {
        try? self.moc.save()
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
