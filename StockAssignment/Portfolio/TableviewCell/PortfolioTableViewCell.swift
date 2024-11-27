//
//  PortfolioTableViewCell.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 27/11/24.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    static var reuseId = "PortfolioTableViewCell"
    struct Constants {
        static let netQuantityLabel = "NET QTY:"
        static let ltpLabel = "LTP:"
        static let pnL = "P&L:"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stockNameLabel)
        contentView.addSubview(ltpLabel)
        contentView.addSubview(netQuantityLabel)
        contentView.addSubview(pAndLLabel)
        setupUI()
    }
    
    let stockNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let ltpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let netQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let pAndLLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupUI() {
        stockNameLabel.anchor(top: contentView.topAnchor,left: contentView.leftAnchor, paddingTop: 12, paddingLeft: 12)
        ltpLabel.anchor(right: contentView.rightAnchor, paddingRight: 12)
        ltpLabel.centerY(inView: stockNameLabel)
        netQuantityLabel.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor,paddingLeft: 12, paddingBottom: 12)
        pAndLLabel.anchor(right: contentView.rightAnchor, paddingRight: 12)
        pAndLLabel.centerY(inView: netQuantityLabel)
    }
    
    func setupData(data: UserHolding) {
        stockNameLabel.text = data.symbol
        let ltpFinalString = NSMutableAttributedString()
        guard let amount = data.ltp?.formatted(.currency(code: "INR")) else {return}
        let stringAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor : UIColor.gray] as [NSAttributedString.Key : Any]
        let atributedString = NSMutableAttributedString(string: Constants.ltpLabel, attributes: stringAttributes)
        ltpFinalString.append(atributedString)
        guard let ltp = data.ltp else { return }
        let valueAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),NSAttributedString.Key.foregroundColor :  (ltp > 0 ? UIColor.black : UIColor.green)] as [NSAttributedString.Key : Any]
        let valueString = NSMutableAttributedString(string: "\(ltp)", attributes: valueAttribute)
        ltpFinalString.append(valueString)
        ltpLabel.attributedText = ltpFinalString
        netQuantityLabel.text = "\(Constants.netQuantityLabel) \(data.quantity ?? 0)"
        if let ltp = data.ltp, let avgPrice = data.avgPrice {
            let pnLFinalString = NSMutableAttributedString()
            let finalValue = round((ltp - avgPrice) * 100) / 100.0
            let stringAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),
                NSAttributedString.Key.foregroundColor : UIColor.gray] as [NSAttributedString.Key : Any]
            let atributedString = NSMutableAttributedString(string: Constants.pnL, attributes: stringAttributes)
            pnLFinalString.append(atributedString)
            let amount = finalValue.formatted(.currency(code: "INR"))
            let valueAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0),NSAttributedString.Key.foregroundColor :  (finalValue > 0 ? UIColor.green : UIColor.red)] as [NSAttributedString.Key : Any]
            let valueString = NSMutableAttributedString(string: "\(amount)", attributes: valueAttribute)
            pnLFinalString.append(valueString)
            pAndLLabel.attributedText = pnLFinalString
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
