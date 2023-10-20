//
//  ViewController.swift
//  iOS_MediaPlayer_App
//
//  Created by Ankit Sharma on 20/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func mp3ButtonClicked(_ sender: Any) {
        let baseURL = URL(string: "https://www.jsonkeeper.com/b/LPEV")
        Router().navigateToMediaListingScreen(navStack: self.navigationController ?? UINavigationController(),
                                              baseUrl: baseURL!)
    }
    
}

