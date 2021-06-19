//
//  UIDeposit.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI

struct UIDeposit: View {
    
    @State private var isDeposit = true
    @State private var date = Date()
    @State private var memo = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        // TODO: if one is pressed, erase the other
                        Button {
                            isDeposit.toggle()
                        } label: {
                            CustomText(text: "Income", size: 20, weight: .bold, design: .default, color: .blue)
                        }
                        
                        Spacer()
                        
                        Button {
                            isDeposit.toggle()
                        } label: {
                            CustomText(text: "Deposit", size: 20, weight: .bold, design: .default, color: .blue)
                        }
                    }
                    // TODO: scrolling calendar로 바꿀 것
                    DatePicker("date", selection: $date, displayedComponents: .date)
                    TextField("memo", text: $memo)
                    
                }
            }
        }
    }
}

struct UIDeposit_Previews: PreviewProvider {
    static var previews: some View {
        UIDeposit()
    }
}
