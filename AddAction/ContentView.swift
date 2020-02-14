//
//  ContentView.swift
//  AddAction
//
//  Created by Ailton Vieira Pinto Filho on 13/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var url: URL
    var completion: (Result<Void, Error>) -> Void
    @State private var app: AppModel?

    var body: some View {
        NavigationView {
            VStack {
                if app == nil {
                    ActivityIndicator(style: .large)
                } else {
                    Text(app!.name)
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
        completion(.success(()))
    }

    func loadApp() {
        AppStoreService.lookupApp(with: url) { result in
            switch result {
            case .success(let app):
                self.app = app
            case .failure(let error):
                self.completion(.failure(error))
            }
        }
    }
}
