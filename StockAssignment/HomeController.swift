//
//  ViewController.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 24/11/24.
//

import UIKit

class HomeController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().backgroundColor = .lightGrayColor
        let portfolioVC = PortfolioViewController()
        navigationController?.navigationItem.title = "PortFolio"
        let watchlistVC = WatchlistViewController()
        let controllers = [portfolioVC,watchlistVC]
        self.viewControllers = controllers
    }


}

