//
//  UIDetail.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIDetail: View {
    
    var blocker: BlockerEntity
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            
            UIDetailMain(blocker: blocker)
                .toolbar(content: {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        CustomSFImage(imageName: "square.and.pencil", width: 30, height: 30)
                    }
                })
                .navigationBarTitle(blocker.name, displayMode: .inline)
                .tag(0)
            
            UIDailyStats(blocker: blocker)
                .toolbar(content: {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        CustomSFImage(imageName: "square.and.pencil", width: 30, height: 30)
                    }
                })
                .navigationBarTitle(blocker.name, displayMode: .inline)
                .tag(1)
            
            UIStats()
                .navigationBarTitle(blocker.name, displayMode: .inline)
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct UIDetailMain: View {
    
    var blocker: BlockerEntity
    @State var isToday: Bool = false
    
    var body: some View {
        
        ZStack {
            Color("peripheralOlive")
                .ignoresSafeArea()
            
            VStack {
                
                if isToday {
                    if blocker.todayStatus == "good" {
                        CustomAssetsImage(imageName: blocker.image.name, width: 350, height: 250, corner: 0)
                    } else {
                        CustomAssetsImage(imageName: "\(blocker.image.name)-neg", width: 350, height: 250, corner: 0)
                    }
                } else {
                    if blocker.status == "good" {
                        CustomAssetsImage(imageName: blocker.image.name, width: 350, height: 250, corner: 0)
                    } else {
                        CustomAssetsImage(imageName: "\(blocker.image.name)-neg", width: 350, height: 250, corner: 0)
                    }
                }
                
                
                VStack {
                    
                    // Toggle Button
                    HStack {
                        HStack {
                            CustomText(text: "Today",
                                       size: 20,
                                       weight: .bold,
                                       design: .default,
                                       color: .black)
                            
                            Toggle("", isOn: $isToday)
                                .labelsHidden()
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    
                    // HP bar
                    ZStack(alignment: .leading) {
                        // 1. 배경선
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .frame(width: 350, height: 30) // TODO: size 절대값으로 넣은 것을 제거해야함
                        
                        if isToday {
                            // 2. HP 색상
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.red)
                                .frame(width: 350*CGFloat(blocker.todayCurrentBudgetPerTodayBudget > 0 ? blocker.todayCurrentBudgetPerTodayBudget : 0), height: 30) // TODO: size 절대값으로 넣은 것을 제거해야함
                            
                            // 3. 텍스트
                            CustomText(text: "\(Int(blocker.todayCurrentBudgetPerTodayBudget*100)) %", size: 15, weight: .bold, design: .default, color: .white)
                                .padding(.horizontal)
                        } else {
                            // 2. HP 색상
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.red)
                                .frame(width: 350*CGFloat(blocker.currentBudgetPerBudget > 0 ? blocker.currentBudgetPerBudget : 0), height: 30) // TODO: size 절대값으로 넣은 것을 제거해야함
                            
                            // 3. 텍스트
                            CustomText(text: "\(Int(blocker.currentBudgetPerBudget*100)) %", size: 15, weight: .bold, design: .default, color: .white)
                                .padding(.horizontal)
                        }
                        
                    }
                    .padding()
                    
                }
                
                VStack(spacing:10) {
                    if isToday {
                        DetailShowView(explainText: "오늘 예산", infoText: IntOrFloat.float(blocker.todayBudget))
                    } else {
                        DetailShowView(explainText: "남은 예산", infoText: IntOrFloat.float(blocker.currentBudget))
                    }
                    
                    if isToday {
                        DetailShowView(explainText: "오늘 지출", infoText: IntOrFloat.float(blocker.todaySpend))
                    } else {
                        DetailShowView(explainText: "현재까지 지출", infoText: IntOrFloat.float(blocker.periodSpend))
                    }
                    
                    DetailShowView(explainText: "예산 만료일까지 남은 기간", infoText: IntOrFloat.int(blocker.dDay))
                    
                }
            }
            
        }
        
        
        
        
    }
}

struct DetailShowView: View {
    
    let explainText: String
    let infoText : IntOrFloat
    
    var body: some View {
        HStack {
            CustomText(text: explainText, size: 20, weight: .medium, design: .default, color: .black)
            
            Spacer()
            
            switch infoText {
            case .int(let i):
                CustomText(text: "\(i)일", size: 20, weight: .medium, design: .default, color: .black)
            case .float(let f):
                CustomText(text: "\(f.currencyRepresentation)", size: 20, weight: .medium, design: .default, color: .black)
            }
            
            
        }
        .padding(.horizontal)
    }
}


//struct UIDetail_Previews: PreviewProvider {
//
//    static var previews: some View {
//        NavigationView {
//            UIDetail(blocker: <#T##BlockerEntity#>)
//
//        }
//        .environmentObject(ImageCoreDataViewModel())
//        .environmentObject(BlockerCoreDataViewModel())
//
//    }
//}
