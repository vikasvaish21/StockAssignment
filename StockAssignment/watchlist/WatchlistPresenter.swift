//
//  WatchlistPresenter.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//

class WatchlistPresenter: WatchlistInteractorOutputProtocol, WatchlistPresenterProtocol {
    var view : WatchlistViewProtocol?
    private let interactor: WatchlistInteractorInputProtocol
    private let router: WatchlistRouterProtocol
    
    init(view: WatchlistViewProtocol, interactor: WatchlistInteractorInputProtocol, router: WatchlistRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
}
