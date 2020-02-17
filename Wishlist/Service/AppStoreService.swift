//
//  AppStoreService.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 11/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation
import CoreData

class AppStoreService {

    static func lookupApp(with url: URL, completion: @escaping (Result<AppModel, Error>) -> Void) {
        let pattern = "\\/id([0-9]*)"

        let text = url.absoluteString

        let appId = text.groups(for: pattern)[0].last!
        print("teste")
        print(appId)

        let url = URL(string: "https://itunes.apple.com/lookup?id=\(appId)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }

                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    let dict = json as! [String: Any]
                    let result = (dict["results"] as! [[String: Any]])[0]

                    let name = result["trackName"] as! String
                    let description = result["description"] as! String
                    let appStoreLink = URL(string: result["trackViewUrl"] as! String)!
                    let genre = result["primaryGenreName"] as! String
                    let kind = result["kind"] as! String
                    let iconURL = URL(string: result["artworkUrl512"] as! String)!
                    let seller = result["sellerName"] as! String
                    let priceValue = (result["price"] as! NSNumber).floatValue
                    let bundleId = result["bundleId"] as! String
                    
                    let price = PriceModel(date: Date(), value: priceValue)
                    
                    let app = AppModel(id: appId, name: name, description: description, url: appStoreLink, genre: genre, kind: kind, iconURL: iconURL, seller: seller, bundleId: bundleId, prices: [price])
                    
                    completion(.success(app))
                }
            }
        }
        task.resume()
    }
}
