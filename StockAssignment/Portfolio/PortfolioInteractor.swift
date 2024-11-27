//
//  PortfolioInteractor.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//

import Foundation
class PortfolioInteractor : PortfolioInputInteractorProtocol {
   
    var presenter: PortfolioOutputInteractorProtocol?
    
    func fetchStockData(url: URL) {
        APIClient.fetchPokemon(url, expecting: StockDataModel.self) { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.presenter?.succesfullyGetStocksData(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCurrentValueForAllHoldings(data: DataClass?) {
        var currentLtp = [Double]()
        guard let ltp = data?.userHolding else {return }
        currentLtp += ltp.map{($0.ltp ?? 0.0) * Double($0.quantity ?? 0)}
        let currentValue = currentLtp.reduce(0, +)
        presenter?.successfullyGetCurrentValue(currentValue: currentValue)
    }
    
    func fetchTotalInvestmentValueForAllHolding(data: DataClass?) {
        var currentAverage = [Double]()
        guard let averagePrice = data?.userHolding else { return }
        currentAverage += averagePrice.map{ ($0.avgPrice ?? 0.0) * Double($0.quantity ?? 0) }
        let currentAverageValue = currentAverage.reduce(0, +)
        presenter?.successfullyGetTotalInvestment(currentValue: currentAverageValue)
    }
    
    func fetchTodayProfitAndLossValue(data: DataClass?) {
        var todayPnl = [Double]()
        guard let pnl = data?.userHolding else { return }
        todayPnl += pnl.map{(Double($0.close ?? 0.0) - Double($0.ltp ?? 0.0)) * Double($0.quantity ?? 0) }
        let todayTotalPnL = todayPnl.reduce(0, +)
        presenter?.successfullyGetTodayProfitAndLossValue(currentValue: todayTotalPnL)
    }
    
}
