//
//  PortfolioRouter.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//

import UIKit

class PortfolioRouter: PortfolioRouterProtocol {
    
    var viewController: UIViewController?
    static func createModule() -> UIViewController {
        let view = PortfolioViewController()
        let interactor = PortfolioInteractor()
        let router = PortfolioRouter()
        let presenter = PortfolioPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }

}
