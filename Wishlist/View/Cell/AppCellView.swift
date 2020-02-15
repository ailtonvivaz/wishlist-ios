//
//  AppCellView.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 14/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SwiftUI

struct AppCellView: View {
    var app: App

    var body: some View {
            HStack(alignment: .center) {
                AppIconView(url: self.app.iconUrl!)
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(self.app.name!)
                        .fontWeight(.regular)
                        .font(.system(.headline))
                        .lineLimit(2)
                    Text(self.app.genre!)
                        .foregroundColor(.gray)
                        .font(.system(.subheadline))
                        .padding(.top, 5)
                }
                Spacer()
            }
        
    }
}

//struct AppCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppCellView(app: Mock.shared.app)
//            .previewLayout(.fixed(width: 300, height: 80))
//    }
//}
