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
    @FetchRequest(entity: AppEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: NSPredicate(format: "filed == NO")) var apps: FetchedResults<AppEntity>

    @State private var showingSheet = false

    var body: some View {
        NavigationView {
            Group {
                if apps.count > 0 {
                    Form {
                        ForEach(self.apps, id: \.id) { app in
                            NavigationLink(destination: AppPageView(app: app)) {
                                AppCellView(app: app)
                            }
                        }
                    }
                } else {
                    Text("You haven't any wish yet.\nPlease add sharing the app by App Store")
                        .multilineTextAlignment(.center)
                }
            }
            .navigationBarTitle("Wishlist")
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
