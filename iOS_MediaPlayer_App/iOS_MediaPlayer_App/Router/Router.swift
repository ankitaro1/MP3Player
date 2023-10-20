//
//  Router.swift
//  iOS_MediaPlayer_App
//
//  Created by Ankit Sharma on 20/10/23.
//

import Foundation
import UIKit

class Router {
    
    func navigateToMediaListingScreen(navStack: UINavigationController, baseUrl: URL) {
        let vc = MediaListViewController()
        let viewModel = MediaListViewModel(baseUrl: baseUrl)
        viewModel.serviceProvider = ServiceDataSource()
        vc.viewModel = viewModel
        viewModel.view = vc
        navStack.pushViewController(vc, animated: true)
    }
}
