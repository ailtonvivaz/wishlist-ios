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
    @FetchRequest(entity: App.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var apps: FetchedResults<App>

    @State private var showingSheet = false

    var body: some View {
        GeometryReader { _ in
            NavigationView {
                VStack {
                    Form {
                        ForEach(self.apps, id: \.self) { app in
//                        Text(app.name ?? "")
                            NavigationLink(destination: Text(app.name!)) {
                                AppCellView(app: app)
//                                    .padding(.vertical)
                                //                                .background(Color.red)
                            }
                        }
                    }
                    Button("Add") {
                        AppStoreService.lookupApp(with: URL(string: "https://apps.apple.com/br/app/blox-o-jogo-dos-blocos/id1470664581")!) { result in
                            switch result {
                            case .success(let app):
                                _ = app.toEntity(with: self.moc)
                                self.save()
                            case .failure:
                                break
                            }
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
