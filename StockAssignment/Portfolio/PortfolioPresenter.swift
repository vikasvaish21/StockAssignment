//
//  PortfolioPresenter.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//

import Foundation
import UIKit

class PortfolioPresenter: PortfolioOutputInteractorProtocol, PortfolioPresenterProtocol {
    
    var view : PortfolioViewProtocol?
    private let interactor: PortfolioInputInteractorProtocol
    private let router: PortfolioRouterProtocol
    private var stocksData: StockDataModel?
    private var currentValue = Double()
    private var totalInvestment = Double()
    
    init(view: PortfolioViewProtocol, interactor: PortfolioInputInteractorProtocol, router: PortfolioRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewdidLoad() {
        getStocksData()
    }
    
    func getStocksData(){
        if let url = Constants.totalStocks {
            interactor.fetchStockData(url: url)
        }
    }

    func getTheCurrenValuesForAllHolding() {
        interactor.fetchCurrentValueForAllHoldings(data: stocksData?.data)
        interactor.fetchTotalInvestmentValueForAllHolding(data: stocksData?.data)
        getTotalProfitAndLoss()
        interactor.fetchTodayProfitAndLossValue(data: stocksData?.data)
    }
    
    
    func succesfullyGetStocksData(data: StockDataModel) {
        stocksData = data
        view?.getStocksData(data: data)
        getTheCurrenValuesForAllHolding()
    }
   
    func successfullyGetCurrentValue(currentValue: Double) {
        self.currentValue = currentValue
        let finalValue = round(currentValue * 100) / 100.0
        view?.getCurrentData(data: finalValue)
    }
    
    func successfullyGetTotalInvestment(currentValue: Double) {
        self.totalInvestment = currentValue
        let finalValue = round(totalInvestment * 100) / 100.0
        view?.getTotalInvestmentValue(data: finalValue)
    }
    
    func getTotalProfitAndLoss() {
        let value = self.currentValue - totalInvestment
        let finalValue = round(value * 100) / 100.0
        view?.getTotalProfitAndLossValue(data: finalValue)
    }
    
    func successfullyGetTodayProfitAndLossValue(currentValue: Double) {
        let finalValue = round(currentValue * 100) / 100.0
        view?.getTodayProfitAndLossValue(data: finalValue)
    }
    
}
