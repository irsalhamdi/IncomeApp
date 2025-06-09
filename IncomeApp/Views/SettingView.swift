//
//  SettingView.swift
//  IncomeApp
//
//  Created by Irsal Hamdi on 09/06/25.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("isOrderDesc") var isOrderDesc : Bool = false
    @AppStorage("currency") var currency : Currency = .idr
    @AppStorage("filterMinimum") var filterMinimum : Double = 0.0
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }

    var body: some View {
        NavigationStack {
            List{
                HStack{
                    Toggle(isOn: $isOrderDesc) {
                        Text("Order \(isOrderDesc ? "(Earliest)" : "(Latest)")")
                    }
                }
                HStack{
                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self){
                            currency in
                            Text(currency.title)
                        }
                    }
                }
                HStack{
                    Text("Filter minimum")
                    TextField("", value: $filterMinimum, formatter: numberFormatter)
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingView()
}
