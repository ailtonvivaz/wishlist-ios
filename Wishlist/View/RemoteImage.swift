//
//  RemoteImage.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 14/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SwiftUI

struct RemoteImage<Label>: View where Label: View {
    private var url: URL
    private var placeholder: () -> Label

    @State private var uiImage: UIImage?

    public init(url: URL, @ViewBuilder placeholder: @escaping () -> Label) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        GeometryReader { geo in
            Group {
                if self.uiImage == nil {
                    self.placeholder()
                } else {
                    Image(uiImage: self.uiImage!)
                        .resizable()
                }
            }.frame(width: geo.size.width, height: geo.size.height)
        }.onAppear {
            RemoteImageService.load(by: self.url) { result in
                switch result {
                case .success(let image):
                    self.uiImage = image
                case .failure:
                    break
                }
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: Mock.shared.app.iconURL) {
            Image("blox")
                .resizable()
        }.previewLayout(.fixed(width: 200, height: 200))
    }
}

