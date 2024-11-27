//
//  PortfolioViewController.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 25/11/24.
//

import Foundation
import UIKit

class PortfolioViewController: UIViewController, PortfolioViewProtocol{
    var presenter: PortfolioPresenterProtocol?
    var stocksData: StockDataModel?
    private let stockTableView = UITableView()
    private var intialState = false
    private let tabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let positionView:UIView = {
        let view = UIView()
        return view
    }()
    
    private let holdingsView:UIView = {
        let view = UIView()
        return view
    }()
    
    private let positionButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let holdingButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let stockStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        return stackview
    }()
    
    private let bottomTotalView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let profitAndLossViewStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 12.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private let profitAndLossView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let profitAndLossTitle: UILabel = {
        let label = UILabel()
        label.text = "profit & Loss"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    private let profitAndLossValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    private let bottomPriceComponentStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fillProportionally
        stackview.backgroundColor = .green
        return stackview
    }()
    
    private let currentValueView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    private let totalInvestmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let totalProfitAndLossView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let currentValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Current value*"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    private let currentDataValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let totalInvestmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Total investment*"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let totalInvestmentValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let totalProfitAndLossLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Profit and Loss*"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let totalProfitAndLossValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.text = "Portfolio"
        return titleLabel
    }()
    
    private let collapseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "downArrow"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        setUpTableview()
        setupTabBarStackView()
        setupBottomTotalView()
        setUpData()
        let button1 = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(addPlay))
        button1.tintColor = .white
        let button2 = UIBarButtonItem(image: UIImage(named: "upDownArrow"), style: .plain, target: self, action: #selector(addPlay))
        button2.tintColor = .white
        let leftItem = UIBarButtonItem(title: "Portfolio", style: .plain, target: nil, action: nil)
        leftItem.image = UIImage(named: "user")
        leftItem.tintColor = UIColor.white
        leftItem.isEnabled = false
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItems = [button1, button2]
        navigationItem.title = "Portfolio"
        navigationItem.titleView = titleLabel
        presenter?.viewdidLoad()
    }
    
    private func showSheet() {
        let vc = PriceBreakdownSheet()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: false)
    }
    
    func setUpTableview() {
        view.addSubview(tabBarView)
        view.addSubview(stockTableView)
        stockTableView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        stockTableView.backgroundColor = .white
        tabBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 44.0)
        stockTableView.anchor(top: tabBarView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        stockTableView.delegate = self
        stockTableView.dataSource = self
        stockTableView.register(PortfolioTableViewCell.self, forCellReuseIdentifier: PortfolioTableViewCell.reuseId)
    }
    
    func setupTabBarStackView() {
        tabBarView.addSubview(stockStackView)
        stockStackView.translatesAutoresizingMaskIntoConstraints = false
        stockStackView.anchor(top: tabBarView.topAnchor, left: tabBarView.leftAnchor, bottom: tabBarView.bottomAnchor, right: tabBarView.rightAnchor)
        stockStackView.addArrangedSubview(positionView)
        stockStackView.addArrangedSubview(holdingsView)
        positionView.addSubview(positionButton)
        holdingsView.addSubview(holdingButton)
        positionButton.anchor(top: positionView.topAnchor, left: positionView.leftAnchor, bottom: positionView.bottomAnchor, right: positionView.rightAnchor)
        holdingButton.anchor(top: holdingsView.topAnchor, left: holdingsView.leftAnchor, bottom: holdingsView.bottomAnchor, right: holdingsView.rightAnchor)
    }
    
    func setupBottomTotalView() {
        bottomTotalView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomTotalView)
        bottomTotalView.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        bottomTotalView.addSubview(profitAndLossViewStack)
        profitAndLossViewStack.translatesAutoresizingMaskIntoConstraints = false
        profitAndLossViewStack.anchor(top: bottomTotalView.topAnchor, left: bottomTotalView.leftAnchor, bottom: bottomTotalView.bottomAnchor, right: bottomTotalView.rightAnchor)
        profitAndLossView.addSubview(profitAndLossTitle)
        profitAndLossView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        profitAndLossView.addSubview(collapseButton)
        profitAndLossTitle.anchor(left: profitAndLossView.leftAnchor, paddingLeft: 12)
        profitAndLossTitle.centerY(inView: profitAndLossView)
        profitAndLossView.addSubview(profitAndLossValue)
        profitAndLossValue.anchor(right: profitAndLossView.rightAnchor, paddingRight: 12)
        profitAndLossValue.centerY(inView: profitAndLossView)
        collapseButton.anchor(left: profitAndLossTitle.rightAnchor,paddingLeft: 4.0 ,width: 20, height: 20)
        collapseButton.centerY(inView: profitAndLossView)
        currentValueView.addSubview(currentValueLabel)
        currentValueView.addSubview(currentDataValue)
        currentValueView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        currentValueLabel.anchor(left: currentValueView.leftAnchor,paddingLeft: 12)
        currentValueLabel.centerY(inView: currentValueView)
        currentDataValue.anchor(right: currentValueView.rightAnchor,paddingRight: 12)
        currentDataValue.centerY(inView: currentValueView)
        totalInvestmentView.addSubview(totalInvestmentLabel)
        totalInvestmentView.addSubview(totalInvestmentValue)
        totalInvestmentView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        totalInvestmentLabel.anchor(left: totalInvestmentView.leftAnchor, paddingLeft: 12)
        totalInvestmentLabel.centerY(inView: totalInvestmentView)
        totalInvestmentValue.anchor(right: totalInvestmentView.rightAnchor,paddingRight: 12)
        totalInvestmentValue.centerY(inView: totalInvestmentView)
        totalProfitAndLossView.addSubview(totalProfitAndLossLabel)
        totalProfitAndLossView.addSubview(totalProfitAndLossValue)
        totalProfitAndLossView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        totalProfitAndLossLabel.anchor(left: totalProfitAndLossView.leftAnchor, paddingLeft: 12)
        totalProfitAndLossLabel.centerY(inView: totalProfitAndLossView)
        totalProfitAndLossValue.anchor(right: totalProfitAndLossView.rightAnchor, paddingRight: 12)
        totalProfitAndLossValue.centerY(inView: totalProfitAndLossView)
    }
    
    func setUpData() {
        positionButton.setTitle("positions", for: .normal)
        holdingButton.setTitle("holdings", for: .normal)
        positionButton.setTitleColor(.black, for: .normal)
        holdingButton.setTitleColor(.black, for: .normal)
        profitAndLossViewStack.addArrangedSubview(bottomPriceComponentStackView)
        profitAndLossViewStack.addArrangedSubview(profitAndLossView)
        bottomPriceComponentStackView.addArrangedSubview(currentValueView)
        bottomPriceComponentStackView.addArrangedSubview(totalInvestmentView)
        bottomPriceComponentStackView.addArrangedSubview(totalProfitAndLossView)
        collapseButton.addTarget(self, action: #selector(collapseButtonAction), for: .touchUpInside)
    }
    
    @objc func addPlay() {
        
    }
    
    @objc func collapseButtonAction() {
        if intialState == false {
            bottomPriceComponentStackView.isHidden = true
            collapseButton.setImage(UIImage(named: "upArrow"), for: .normal)
            intialState = true
        } else {
            bottomPriceComponentStackView.isHidden = false
            collapseButton.setImage(UIImage(named: "downArrow"), for: .normal)
            intialState = false
        }
    }
    
    func getStocksData(data: StockDataModel) {
        stocksData = data
        stockTableView.reloadData()
    }
    
    func getCurrentData(data: Double) {
        let amount = data.formatted(.currency(code: "INR"))
        currentDataValue.text = "\(amount)"
    }
    
    func getTotalInvestmentValue(data: Double) {
        let amount = data.formatted(.currency(code: "INR"))
        totalInvestmentValue.text = "\(amount)"
    }
    
    func getTotalProfitAndLossValue(data: Double) {
        if data < 0 {
            profitAndLossValue.textColor = UIColor.red
        }
        let amount = data.formatted(.currency(code: "INR"))
        profitAndLossValue.text = "\(amount)"
    }
    
    func getTodayProfitAndLossValue(data: Double) {
        if data < 0 {
            totalProfitAndLossValue.textColor = UIColor.red
        }
        let amount = data.formatted(.currency(code: "INR"))
        totalProfitAndLossValue.text = "\(amount)"
    }

}

extension  PortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioTableViewCell.reuseId) as? PortfolioTableViewCell else { return UITableViewCell() }
        if let userHoldings = stocksData?.data?.userHolding {
            cell.setupData(data: userHoldings[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
