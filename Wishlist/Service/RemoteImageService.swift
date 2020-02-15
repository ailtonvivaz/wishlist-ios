//
//  RemoteImageService.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 14/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation
import SwiftUI

class RemoteImageService: ObservableObject {
    
    static func load(by url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(UIImage(data: data)!))
        }.resume()
    }
    
}
