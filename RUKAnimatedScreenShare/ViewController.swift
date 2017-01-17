//
//  ViewController.swift
//  RUKAnimatedScreenShare
//
//  Created by Sierra Solutions Mac User 5 on 13/1/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let newLayer = CALayer()
    @IBOutlet weak var feedview: RUKShareView!
    var shareMenuVisible = false
    var networksIcons = ["fb","whatsapp","twitter","email"]
    var networksTitles = ["Facebook","Whatsapp","Twitter","E-mail"]
    override func viewDidLoad() {
        super.viewDidLoad()
        feedview.slidingDelegate = self
    }


    @IBAction func start(_ sender: Any) {
        
        
    }

    @IBAction func stop(_ sender: Any) {
        feedview.hideShareOptions()

    }
    @IBAction func share(_ sender: UIBarButtonItem) {
        if !shareMenuVisible{
            feedview.showShareOptions(networkIcons:networksIcons,networkNames: networksTitles, _completion: { (_index) in
                //Get index of Network Selected
                var title : String?
                if let item = NETWORKS(rawValue: _index!) {
                    switch item {
                    case .FACEBOOK:
                        title = "Share via Facebook"
                        print("FACEBOOK tab")
                    case .WHATSAPP:
                        title = "Share via Whatsapp"
                    case .TWITTER:
                        title = "Share via Twitter"
                    case .EMAIL:
                        title = "Share via E-mail"
                    }
                }
                let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
                self.feedview.hideShareOptions()
            })
        }else{
            feedview.hideShareOptions()
            shareMenuVisible = false
        }
    }

}
extension ViewController: RUKShareViewSliding{
    func didSlideOut() {
        shareMenuVisible = true
    }
    func didSlideIn() {
        shareMenuVisible = false
    }
}

