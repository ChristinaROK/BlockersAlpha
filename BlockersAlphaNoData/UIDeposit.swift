//
//  UIDeposit.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI

struct UIDeposit: View {
    
    let stateOptions: [String] = [
        "수입", "지출"
    ]
    @State private var currentState = "지출"
    @State private var amount = ""
    @State private var date = Date()
    @State private var memo = ""
    @State private var isSave = false
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.systemGreen
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                //  TODO: 현재 static value를 blocker model 받는 value로 교체
                VStack {
                    CustomText(text: "blocker name", size: 20, weight: .bold, design: .default, color: .black)
                    CustomAssetsImage(imageName: "add-blocker", width: 200, height: 100, corner: 0.2)
                }
                
                Spacer(minLength: 100)
                
                Form {
                    Section {
                        Picker(selection: $currentState,
                               label: Text("Picker"),
                               content: {
                                ForEach(stateOptions.indices) {
                                    index in Text(stateOptions[index])
                                        .tag(stateOptions[index])
                                }
                               })
                            .pickerStyle(SegmentedPickerStyle())
                        
                        // TODO: customized number keyboard로 바꿀 것 (직접 구현!!!)
                        TextField("amount", text: $amount)
                        
                        // TODO: scrolling calendar로 바꿀 것
                        DatePicker("date", selection: $date, displayedComponents: .date)
                        
                        TextField("memo", text: $memo)
                        
                    }
                    
                    // TODO: issave=true 일 때 값을 CoreData에 보내도록하는 함수 추가
                    Section {
                        Button {
                            isSave.toggle()
                        } label: {
                            CustomText(text: "Save", size: 15, weight: .semibold, design: .default, color: Color.blue)
                        }
                    }
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
