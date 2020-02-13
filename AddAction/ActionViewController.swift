//
//  ActionViewController.swift
//  AddAction
//
//  Created by Ailton Vieira Pinto Filho on 10/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import MobileCoreServices
import UIKit

class ActionViewController: UIViewController {
    let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.spinner)
        self.spinner.startAnimating()
        self.spinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            var urlFound = false
            for provider in item.attachments! {
                if provider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                    provider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil, completionHandler: { url, error in
                        guard let url = url as? URL else {
                            print(error!.localizedDescription)
                            return
                        }
                        print(url)
                        OperationQueue.main.addOperation {
                            AppStoreService.lookupApp(with: url) { result in
//                                self.spinner.removeFromSuperview()
                                switch result {
                                case .success(let app):
                                    print(app)
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                    })

                    urlFound = true
                    break
                }
            }

            if urlFound {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
}
