//
//  PortfolioProtocol.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//

import Foundation



protocol PortfolioViewProtocol {
    func getStocksData(data: StockDataModel)
    func getCurrentData(data: Double)
    func getTotalInvestmentValue(data: Double)
    func getTotalProfitAndLossValue(data: Double)
    func getTodayProfitAndLossValue(data: Double)
}

protocol PortfolioPresenterProtocol {
    func viewdidLoad() 
}

protocol PortfolioInputInteractorProtocol {
    var presenter: PortfolioOutputInteractorProtocol? { get set }
    func fetchStockData(url: URL)
    func fetchCurrentValueForAllHoldings(data: DataClass?)
    func fetchTotalInvestmentValueForAllHolding(data: DataClass?)
    func fetchTodayProfitAndLossValue(data: DataClass?)
    
}

protocol PortfolioOutputInteractorProtocol {
    func succesfullyGetStocksData(data: StockDataModel)
    func successfullyGetCurrentValue(currentValue: Double)
    func successfullyGetTotalInvestment(currentValue: Double)
    func successfullyGetTodayProfitAndLossValue(currentValue: Double)
}

protocol PortfolioRouterProtocol {
    
}
