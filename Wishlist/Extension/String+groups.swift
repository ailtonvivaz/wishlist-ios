//
//  String+groups.swift
//  Wishlist
//
//  Created by Ailton Vieira Pinto Filho on 11/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

extension String {
    func groups(for regexPattern: String) -> [[String]] {
        do {
            let text = self
            let regex = try NSRegularExpression(pattern: regexPattern)
            let matches = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return matches.map { match in
                (0..<match.numberOfRanges).map {
                    let rangeBounds = match.range(at: $0)
                    guard let range = Range(rangeBounds, in: text) else {
                        return ""
                    }
                    return String(text[range])
                }
            }
        } catch {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
