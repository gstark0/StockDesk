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
    @State private var symbols = ["AAPL"]
    
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
                        
                    }
                    .padding(.trailing, 20)
                }
                List {
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("AAPL")
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
                            Text("1482,76")
                                .padding(.bottom, 5)
                            Text("-0.3488%")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
