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
    
    var body: some View {
        NavigationView {
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
                        Text("1482.76")
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
            .navigationBarItems(trailing: Button("Add") {
                self.showModal = true
            })
            .sheet(isPresented: $showModal) {
                AddStock()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
