//
//  AppPageView.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 16/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SwiftUI

struct AppPageView: View {
    var app: AppEntity

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center, spacing: 20) {
                    AppIconView(url: self.app.iconUrl!)
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(self.app.name!)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(2)
                        Text(self.app.genre!)
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                            .font(.headline)
                        Button(action: self.openAppStore) {
                            Text("GET")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 5)
                        }
                        .background(Color.blue)
                        .clipShape(Capsule())
                    }
                    Spacer()
                }
                Text(app.desc!)
                    .lineLimit(10)
                Spacer()
            }.padding()
        }
    }
    
    func openAppStore() {
        if let url = app.url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
