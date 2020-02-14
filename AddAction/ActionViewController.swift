//
//  ActionViewController.swift
//  AddAction
//
//  Created by Ailton Vieira Pinto Filho on 10/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import MobileCoreServices
import SwiftUI
import UIKit

class ActionViewController: UIHostingController<AnyView> {
//    var contentView = ContentView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(rootView: AnyView(ActivityIndicator(style: .large)))
    }
    
    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var urlFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            guard let urlProvider = item.attachments!.first(where: { $0.hasItemConformingToTypeIdentifier(kUTTypeURL as String) }) else {
                continue
            }
            
            urlFound = true
            
            urlProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { url, error in
                guard let url = url as? URL else {
                    self.completion(.failure(error!))
                    return
                }
                
                OperationQueue.main.addOperation {
                    let contentView = ContentView(url: url, completion: self.completion)
                    self.rootView = AnyView(contentView)
                }
                
            })
            break
        }
        
        if !urlFound {
            self.completion(.failure(NSError(domain: "Error", code: -1, userInfo: nil)))
        }
    }
    
    func completion(_ result: Result<Void, Error>) {
        switch result {
        case .failure(let error):
            self.extensionContext?.cancelRequest(withError: error)
        default:
            self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
        }
    }
}
