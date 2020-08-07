//
//  ContentView.swift
//  StockDesk
//
//  Created by Greg Stark on 04/08/2020.
//  Copyright © 2020 Gregory Stark. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var showModal = false
    @State private var newSymbol = ""
    @State private var companies:[Company] = []
    
    @State private var showingAlert = false
    
    static let apiKey = ""
    
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
                        self.newSymbol = self.newSymbol.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
                        if self.newSymbol.contains(" ") {self.newSymbol = ""; return}
                        self.companies.append(Company(symbol: self.newSymbol))
                        
                        // Fetch prices
                        self.fetchPrices(symbol: self.newSymbol, finished: { newPrice, newChange in
                            self.companies[self.companies.count-1].price = newPrice
                            self.companies[self.companies.count-1].change = newChange
                        })
                        
                        //Fetch info
                        self.fetchCompanyInfo(symbol: self.newSymbol, finished: { sector, exchange, name in
                            print("WORKS #2")
                            self.companies[self.companies.count-1].name = name
                            self.companies[self.companies.count-1].exchange = exchange
                            self.companies[self.companies.count-1].name = sector
                        })
                        
                        self.newSymbol = ""
                        
                    }
                    .padding(.trailing, 20)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Symbol not found"), message: Text("Sorry, symbol you provided couldn't be found!"))
                    }
                }
                List {
                    ForEach(companies, id: \.self) { company in
                        HStack {
                            VStack(alignment: .leading) {
                                Spacer()
                                Text(company.symbol)
                                    .font(.system(size: 21))
                                    .bold()
                                Text(company.name)
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
                                    .background(company.change.contains("-") ? Color.red : Color.green)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(5)
                                Spacer()
                            }
                        }
                    }
                    .onDelete(perform: self.deleteCompany)
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
    
    func deleteCompany(at offsets: IndexSet) {
        companies.remove(atOffsets: offsets)
    }
    
    func fetchCompanyInfo(symbol: String, finished: @escaping (String, String, String) -> Void) {
        let infoUrl = URL(string: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=\(symbol)&apikey=\(ContentView.apiKey))")!
        URLSession.shared.dataTask(with: infoUrl) { data, response, error in
            do {
                let companyData = try JSONDecoder().decode(InfoResponse.self, from: data!)
                print(companyData.Name)
                finished(companyData.Name, companyData.Exchange, companyData.Sector)
            } catch {
                print("Error loading company info")
            }
        }.resume()
    }
    
    func fetchPrices(symbol: String, finished: @escaping (String, String) -> Void) {
        let priceUrl = URL(string: "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=\(ContentView.apiKey)")!
        URLSession.shared.dataTask(with: priceUrl) { data, response, error in
            do {
                let pricesData = try JSONDecoder().decode(PricesResponse.self, from: data!)
                finished(pricesData.globalQuote.price, pricesData.globalQuote.change)
            } catch {
                print("Something went wrong!")
                self.showingAlert = true
                self.companies.removeLast()
            }
            
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
