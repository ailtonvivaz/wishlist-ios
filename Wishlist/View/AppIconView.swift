//
//  AppIconView.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 14/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SwiftUI

struct AppIconView: View {
    var url: URL

    var body: some View {
        GeometryReader { geo in
            RemoteImage(url: self.url) {
                Image("EmptyIcon")
                    .resizable()
            }
            .cornerRadius(0.225 * geo.size.height)
            .frame(height: geo.size.height)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                RoundedRectangle(cornerRadius: 0.225 * geo.size.height)
                    .stroke(Color.primary.opacity(0.15), lineWidth: 0.005 * geo.size.height)
            )
        }
    }
}

struct AppIconView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconView(url: Mock.shared.app.iconURL)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
