//
//  UIDetail.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIDetail: View {
    
    var blocker: BlockerModel
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            
            UIDetailMain(blocker: blocker)
                .navigationBarItems(trailing: CustomSFImage(imageName: "square.and.pencil", width: 30, height: 30))
                .navigationBarTitle(blocker.name, displayMode: .inline)
                .tag(0)
            
            UIDailyStats()
                .navigationBarItems(trailing: CustomSFImage(imageName: "square.and.pencil", width: 30, height: 30))
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
    
    var blocker: BlockerModel
    @State var isToday: Bool = false
    
    var body: some View {
        
        ZStack {
            Color("peripheralOlive")
                .ignoresSafeArea()
            
            VStack {
                CustomAssetsImage(imageName: blocker.image, width: 350, height: 250, corner: 0)
                
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
                        
                        // 2. HP 색상
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.red)
                            .frame(width: 350*CGFloat(blocker.currentPercentage), height: 30) // TODO: size 절대값으로 넣은 것을 제거해야함
                        
                        // 3. 텍스트
                        CustomText(text: "\(Int(blocker.currentPercentage*100)) %", size: 15, weight: .bold, design: .default, color: .white)
                            .padding(.horizontal)
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
                        // TODO: 해당 variable model 생성한 후 적용하기
                        DetailShowView(explainText: "오늘 지출", infoText: IntOrFloat.float(-999))
                    } else {
                        DetailShowView(explainText: "현재까지 지출", infoText: IntOrFloat.float(blocker.spent ?? 0))
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


struct UIDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let blocker1: BlockerModel = BlockerModel(name: "식비", image: "eat-blocker", budget: 500000, period: .monthly, resetDate: DateComponents(day:1), spent: 300000, startDate: nil, endDate: nil, histories: [])
        
        NavigationView {
            UIDetail(blocker: blocker1)
        }
    }
}

