//
//  WatchlistRouter.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//


import Foundation
import UIKit

class WatchlistRouter: WatchlistRouterProtocol {
    var viewController : UIViewController?
    static func createModule() -> UIViewController {
        let view = WatchlistViewController()
        let interactor = WatchlistInteractor()
        let router = WatchlistRouter()
        let presenter = WatchlistPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
