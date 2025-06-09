//
//  ContentView.swift
//  IncomeApp
//
//  Created by Irsal Hamdi on 08/06/25.
//

import SwiftUI

struct HomeView: View {
    @State private var transactions: [TransactionModel] = []
    @State private var showEditTransactionView = false
    @State private var transactionToEdit: TransactionModel?
    @State private var showSettings = false
    
    @AppStorage("isOrderDesc") var orderDescending = false
    @AppStorage("currency") var currency : Currency = .idr
    @AppStorage("filterMinimum") var filterMinimum : Double = 0.0
    
    private var displayTransactions: [TransactionModel] {
        let sortedTransactions = orderDescending ? transactions.sorted(by: {
            $0.date < $1.date }) : transactions.sorted(by: { $0.date > $1.date })
        let filterTransaction = sortedTransactions.filter( {$0.amount > filterMinimum} )
        return filterTransaction
    }
    
    private var expenses: String{
        let sumExpense = transactions.filter(
            { $0.type == .expense }).reduce(0, { $0 + $1.amount }
        )
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        
        return numberFormatter.string(from: sumExpense as NSNumber) ?? "RP 0.00"
    }
    
    private var income: String{
        let sumIncome = transactions.filter(
            { $0.type == .income }).reduce(0, { $0 + $1.amount }
        )
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "RP.00"
    }
    
    private var total: String{
        let sumExpense = transactions.filter(
            { $0.type == .expense }).reduce(0, { $0 + $1.amount }
        )
        let sumIncome = transactions.filter(
            { $0.type == .income }).reduce(0, { $0 + $1.amount }
        )
        
        let total = sumIncome - sumExpense
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        
        return numberFormatter.string(from: total as NSNumber) ?? "RP.00"
    }
    
    fileprivate func FloatButton() -> some View{
        VStack{
            Spacer()
            NavigationLink{
                AddTransactionView(transactions: $transactions)
            }label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 7)
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
        }
    }
    
    fileprivate func BalanceView() -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            VStack(alignment: .leading, spacing: 5){
                HStack{
                    VStack(alignment: .leading){
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                        Text("\(total)")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                }
                .padding(.top)
                HStack(spacing: 25){
                    VStack(alignment: .leading){
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(expenses)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                    VStack(alignment: .leading){
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(income)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                        
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List{
                        ForEach(displayTransactions) { transaction in
                            Button {
                                transactionToEdit = transaction
                            } label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            }
                        }.onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatButton()
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactions: $transactions, transactionToEdit: transactionToEdit)
            })
            .navigationDestination(isPresented: $showEditTransactionView, destination: {
                AddTransactionView(transactions: $transactions)
            })
            .sheet(isPresented: $showSettings, content: {
                SettingView()
            })
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet){
        transactions.remove(atOffsets: offsets)
    }
}

#Preview {
    HomeView()
}
