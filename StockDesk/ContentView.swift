//
//  ContentView.swift
//  StockDesk
//
//  Created by Greg Stark on 04/08/2020.
//  Copyright © 2020 Gregory Stark. All rights reserved.
//

import SwiftUI

struct Company: Hashable {
    var symbol: String
    var name: String
    var price: String
    var change: String
}

struct ContentView: View {
    @State private var showModal = false
    @State private var newSymbol = ""
    @State private var companies:[Company] = []
    
    let apiKey = "ST8LDHI0C2SY672P"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add company by symbol...", text: $newSymbol)
                        .padding(7)
                        .padding(.horizontal, 15)
                        .background(Color(.systemGray6))
                        .cornerRadius(6)
                        .padding(.horizontal)
                    Button("Add") {
                        self.companies.append(Company(symbol: self.newSymbol, name: "Company", price: "0.00", change: "0.00"))
                        self.getCompanyData(symbol: self.newSymbol, finished: { newCompany in
                            self.companies[self.companies.count-1] = newCompany
                        })
                        self.newSymbol = ""
                    }
                    .padding(.trailing, 20)
                }
                List(companies, id: \.self) { company in
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(company.symbol)
                                .font(.system(size: 21))
                                .bold()
                            Text("Apple Inc")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            Text(company.price)
                                .padding(.bottom, 5)
                            Text(company.change)
                                .font(.subheadline)
                                .bold()
                                .padding(5)
                                .background(Color.red)
                                .foregroundColor(Color.white)
                                .cornerRadius(5)
                            Spacer()
                        }
                    }
                }
                .navigationBarTitle("StockDesk")
                /*.navigationBarItems(trailing: Button("Add") {
                    self.showModal = true
                })
                .sheet(isPresented: $showModal) {
                    AddStock()
                }*/
            }
        }
    }
    
    func getCompanyData(symbol: String, finished: @escaping (Company) -> Void) {
        let priceUrl = URL(string: "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=\(apiKey)")!
        var companyData = Company(symbol: symbol, name: "Apple Inc", price: "0.00", change: "0.00")
        URLSession.shared.dataTask(with: priceUrl) { data, response, error in
            do {
                let pricesData = try JSONDecoder().decode(ApiResponse.self, from: data!)
                print(pricesData.globalQuote.price)
                companyData.price = pricesData.globalQuote.price
                companyData.change = pricesData.globalQuote.change
            } catch {
                print("Something went wrong!")
            }
            
            finished(companyData)
        }.resume()
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
