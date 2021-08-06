//
//  UIDeposit.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI

struct UIDeposit: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var imageViewModel : ImageViewModel
    
    let stateOptions: [String] = [
        "수입", "지출"
    ]
    @State private var currentState = "지출"
    @State private var amount = ""
    @State private var date = Date()
    @State private var memo = ""
    @State private var isSave = false
    @State private var currentIndex: Int = 0
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.systemGreen
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        
            VStack {
                
                HStack {
                    
                    Button(action: {
                        currentIndex = leftClick(curIndex: currentIndex, len: imageViewModel.currentImages.count)
                    }, label: {
                        CustomSFImage(imageName: "arrowtriangle.backward.fill", width: 20, height: 20)
                    })
                    .padding()
                    
                    CustomAssetsImage(imageName:
                                        imageViewModel.currentImages[currentIndex].image, width: 200, height: 150, corner: 0)
                    
                    Button(action: {
                        currentIndex = rightClick(curIndex: currentIndex, len: imageViewModel.currentImages.count)
                    }, label: {
                        CustomSFImage(imageName: "arrowtriangle.forward.fill", width: 20, height: 20)
                    })
                    .padding()
                    
                }
                .padding(.vertical, 100)
                
                
                Form {
                    Section {
                        // TODO: picker 선택값 적용을 위해 .onChange modifier 사용할 것
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
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        
                        CustomSFImage(imageName: "xmark.circle", width: 30, height: 30, corner: 0)
                        
                    }
                }
            }
            .navigationBarTitle("예산 기록", displayMode: .inline)
    }
    
    func rightClick(curIndex:Int, len:Int) -> Int {
        var newIndex = curIndex+1
        if newIndex==len {
            newIndex = 0
        }
        return newIndex
    }

    func leftClick(curIndex:Int, len:Int) -> Int {
        var newIndex = curIndex-1
        if newIndex == -1 {
            newIndex = len-1
        }
        return newIndex
    }
}


struct UIDeposit_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UIDeposit()
        }
        .environmentObject(BlockerViewModel())
        .environmentObject(ImageViewModel())
    }
}
