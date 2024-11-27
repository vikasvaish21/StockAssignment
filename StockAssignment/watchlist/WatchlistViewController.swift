//
//  WatchlistViewController.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//

import Foundation
import UIKit

class WatchlistViewController: UIViewController, WatchlistViewProtocol {
    
    var presenter: WatchlistPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setNaviagtionBar()
    }
    
    
//    func setNaviagtionBar() {
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        if #available(iOS 13.0, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = UIColor.primaryColor
//            navigationController?.navigationBar.standardAppearance = appearance
//            navigationController?.navigationBar.scrollEdgeAppearance = appearance
//            navigationController?.navigationBar.compactAppearance = appearance
//
//        }
//    }
    
}
