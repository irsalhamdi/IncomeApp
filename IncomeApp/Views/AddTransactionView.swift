//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by Irsal Hamdi on 08/06/25.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount: Double = 0.00
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var transactionTitle : String = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @Binding var transactions : [TransactionModel]
    var transactionToEdit: TransactionModel?
    @Environment(\.dismiss) var dismiss
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        VStack{
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Rectangle()
                .fill(Color(uiColor: UIColor.lightGray))
                .frame(height: 0.5)
                .padding(.horizontal, 30)
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            Button(action: {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be 2 or more characters long"
                    showAlert = true
                    return
                }
                
                let transaction = TransactionModel(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                
                if let transactionToEdit = transactionToEdit {
                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit)else{
                        alertTitle = "Something went wrong"
                        alertMessage = "Can not update this transaction"
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = transaction
                }else{
                    transactions.append(transaction)
                }
                
                dismiss()
            }, label: {
                Text(transactionToEdit == nil ? "Create": "Update")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            })
            .padding(.top)
            .padding(.horizontal, 30)
            Spacer()
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                selectedTransactionType = transactionToEdit.type
            }
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button(action: {
                
            }, label: {
                Text("OK")
            })
        } message: {
            Text(alertMessage)
        }

    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
