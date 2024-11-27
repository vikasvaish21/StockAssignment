//
//  StockDataModel.swift
//  StockAssignment
//
//  Created by Vikas Vaish on 27/11/24.
//

struct StockDataModel: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let userHolding: [UserHolding]?
}

// MARK: - UserHolding
struct UserHolding: Codable {
    let symbol: String?
    let quantity: Int?
    let ltp, avgPrice, close: Double?
}
