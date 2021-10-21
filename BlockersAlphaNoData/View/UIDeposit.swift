//
//  UIDeposit.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI

struct UIDeposit: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var blockerViewModel : BlockerCoreDataViewModel
    @EnvironmentObject var historyViewModel : HistoryCoreDataViewModel
    
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
        
        NavigationView {
            
            VStack {
                
                if blockerViewModel.currentBlockers.count > 0 {
                    HStack {
                        
                        Button(action: {
                            currentIndex = leftClick(curIndex: currentIndex, len: blockerViewModel.currentBlockers.count)
                        }, label: {
                            CustomSFImage(imageName: "arrowtriangle.backward.fill", width: 20, height: 20)
                        })
                            .padding()
                        
                        VStack {
                            CustomAssetsImage(imageName:
                                                blockerViewModel.currentBlockers[currentIndex].image.name, width: 200, height: 150, corner: 0)
                            CustomText(text: "\(blockerViewModel.currentBlockers[currentIndex].name)", size: 25, weight: .bold, design: .default, color: Color.black)
                        }
                        
                        Button(action: {
                            currentIndex = rightClick(curIndex: currentIndex, len: blockerViewModel.currentBlockers.count)
                        }, label: {
                            CustomSFImage(imageName: "arrowtriangle.forward.fill", width: 20, height: 20)
                        })
                            .padding()
                        
                    }
                    .padding(.vertical, 70)
                    
                    
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
                    }
                    
                    HStack(spacing:0) {
                        
                        if #available(iOS 15, *) {
                            Button {
                                // 1. historyEntity 추가 (blocker.history 도 업데이트)
                                historyViewModel.addHistoryEntity(
                                    blocker: blockerViewModel.currentBlockers[currentIndex],
                                    state: currentState,
                                    amount: amount,
                                    date: date,
                                    memo: memo
                                )
                                
                                isSave.toggle()
                                
                                // 2. currentBlockers 업데이트
                                //blockerViewModel.save()
                                
                            } label: {
                                CustomText(text: "추가 등록", size: 25, weight: .semibold, design: .default, color: Color.white)
                                    .padding()
                                    .frame(height:80)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("Nolive"))
                                    .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
                                    .cornerRadius(0)
                            }
                            .alert("현재 입력한 예산 기록은 저장됩니다. 예산 기록을 추가로 등록하시겠습니까?", isPresented: $isSave,
                                   actions: {
                                Button("확인", role: .cancel, action: {
                                    // 초기화
                                    amount = ""
                                    date = Date()
                                    memo = ""
                                })
                            },
                                   message: {}
                            )
                            .disabled(amount.isEmpty)
                        }
                        else {
                            Button {
                                // 1. historyEntity 추가 (blocker.history 도 업데이트)
                                historyViewModel.addHistoryEntity(
                                    blocker: blockerViewModel.currentBlockers[currentIndex],
                                    state: currentState,
                                    amount: amount,
                                    date: date,
                                    memo: memo
                                )
                                
                                isSave.toggle()
                                
                                // 2. currentBlockers 업데이트
                                //blockerViewModel.save()
                                
                            } label: {
                                CustomText(text: "추가 등록", size: 25, weight: .semibold, design: .default, color: Color.white)
                                    .padding()
                                    .frame(height:80)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("Nolive"))
                                    .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
                                    .cornerRadius(0)
                            }
                            .alert(isPresented:$isSave) {
                                Alert(title: Text(""),
                                      message: Text("현재 입력한 예산 기록은 저장됩니다. 예산 기록을 추가로 등록하시겠습니까?"),
                                      dismissButton: .default(Text("확인"),
                                                              action: {
                                    // 초기화
                                    amount = ""
                                    date = Date()
                                    memo = ""
                                }                            )
                                )
                            }
                            .disabled(amount.isEmpty)
                        }
                        
                        
                        
                        Button {
                            
                            // 1. historyEntity 추가 (blocker.history 도 업데이트)
                            historyViewModel.addHistoryEntity(
                                blocker: blockerViewModel.currentBlockers[currentIndex],
                                state: currentState,
                                amount: amount,
                                date: date,
                                memo: memo
                            )
                            
                            // 2. currentBlockers 업데이트
                            //blockerViewModel.save()
                            
                            // 3. 창 닫기
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            CustomText(text: "완료", size: 25, weight: .semibold, design: .default, color: Color.white)
                                .padding()
                                .frame(height:80)
                                .frame(maxWidth: .infinity)
                            //.frame(width: 200, height: 100, alignment: .center)
                                .background(Color.green)
                                .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
                                .cornerRadius(0)
                        }
                        .disabled(amount.isEmpty)
                        
                    }
                    .padding()
                    
                }
                else {
                    CustomText(text: "⚠️ 예산 블록을 먼저 만들어주세요", size: 20, weight: .bold, design: .default, color: .black)
                }
            }
            .navigationBarItems(leading:
                                    Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                CustomSFImage(imageName: "arrow.backward", width: 25, height: 22, corner: 0)
            }
                                
            )
            .navigationBarTitle("예산 기록", displayMode: .inline)
        }
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
        UIDeposit()
            .environmentObject(BlockerCoreDataViewModel())
            .environmentObject(HistoryCoreDataViewModel())
    }
}
