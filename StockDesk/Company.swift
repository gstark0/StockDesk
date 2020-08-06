//
//  Company.swift
//  StockDesk
//
//  Created by Greg Stark on 06/08/2020.
//  Copyright © 2020 Gregory Stark. All rights reserved.
//

import SwiftUI

struct Company: Hashable {
    var symbol: String
    
    var name = "Name"
    var exchange = ""
    var sector = ""
    
    var price = "0.00"
    var change = "0.00"
}

// API
struct PricesResponse: Codable {
    var globalQuote: GlobalQuote
    
    enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
}

struct GlobalQuote: Codable {
    var symbol: String
    var price: String
    var change: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case price = "05. price"
        case change = "10. change percent"
    }
}

struct InfoResponse: Codable {
    var Name: String
    var Exchange: String
    var Sector: String
}
