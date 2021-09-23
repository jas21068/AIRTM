//
//  AddCard.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-14.
//

import Foundation
import SwiftUI

struct AddCard: View {
    @State private var name = ""
    @State private var type = "Visa"
    @State private var Currency = "CAD"
    @State private var amount = ""
    @State private var Date = ""
    @State private var Description = ""
    
    @Environment(\.presentationMode) var presentationMode
    static let types = ["Visa", "Mastercard", "Amex"]
    static let CurrencyTypes = ["CAD", "USD"]
    @ObservedObject var expenses: Cards
    var body: some View {
        NavigationView {
            Form {
                TextField("name on Card", text: $name)
                TextField("Card Number", text: $amount)
                    .keyboardType(.numberPad)
                HStack{
                    
                    Picker("Card Type", selection: $type) {
                        ForEach(Self.types, id: \.self) {
                            Text($0)
                        }
                    }
                }
                TextField("Expiry Date", text: $Date)
                
                TextField("CVV", text: $Description)
            }
            .navigationBarTitle("Add a new card ")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = CardItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.foregroundColor(Color(.blue)))
        }
    }
}

