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
    var name: String
    var price: String
    var change: String
}

// API
struct ApiResponse: Codable {
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
