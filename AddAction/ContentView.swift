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

    @State private var loading = true
    @State private var error: Error?

    var body: some View {
        NavigationView {
            VStack {
                if loading {
                    ActivityIndicator(style: .large)
                } else {
                    VStack {
                        if app != nil {
                            AppCellView(app: app!)
                        }
                        Spacer()
                        Group {
                            if error == nil {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 80))
                                    .padding()
                                Text("App added to Wishlist")
                                    .padding(.top)
                            } else {
                                Image(systemName: "xmark")
                                    .font(.system(size: 80))
                                    .padding()
                                Text("Error adding to Wishlist")
                                    .padding(.top)
                            }
                        }
                        .foregroundColor(.gray)
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
        if let error = error {
            completion(.failure(error))
        } else {
            save()
            completion(.success(()))
        }
    }

    func loadApp() {
        AppStoreService.lookupApp(with: url) { result in
            switch result {
            case .success(let app):
                let appEntity = app.toEntity(with: self.moc)
                self.save()
                self.app = appEntity
                self.loading = false
            case .failure(let error):
                self.error = error
                self.loading = false
            }
        }
    }

    func save() {
        do {
            try moc.save()
            print("sucesso")
        } catch {
            self.error = error
            print(error.localizedDescription)
        }
    }
}
