//
//  ContentView.swift
//  AddAction
//
//  Created by Ailton Vieira Pinto Filho on 13/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @State var url: URL
    var completion: (Result<Void, Error>) -> Void
    @State private var app: AppEntity?

    var body: some View {
        NavigationView {
            VStack {
                if app == nil {
                    ActivityIndicator(style: .large)
                } else {
                    VStack {
                        AppCellView(app: app!)
                        Spacer()
                    }.padding()
                }
            }
            .onAppear(perform: loadApp)
            .navigationBarTitle(Text("Add to Wishlist"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: doneTapped, label: {
                Text("Done").bold()
            }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func doneTapped() {
        if app != nil {
            save()
            completion(.success(()))
        }
    }

    func loadApp() {
        AppStoreService.lookupApp(with: url) { result in
            switch result {
            case .success(let app):
                self.app = app.toEntity(with: self.moc)
            case .failure(let error):
                self.completion(.failure(error))
            }
        }
    }

    func save() {
        do {
            try moc.save()
            print("sucesso")
        } catch {
            print(error.localizedDescription)
        }
    }
}
