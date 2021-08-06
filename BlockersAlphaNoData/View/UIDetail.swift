//
//  UIDetail.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIDetail: View {
    
    var blocker: BlockerModel
    @State var isToday: Bool = false
    
    var body: some View {
        VStack {
            CustomAssetsImage(imageName: blocker.image, width: 350, height: 250, corner: 0)
            
            VStack {
                
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
        .navigationBarItems(trailing: CustomSFImage(imageName: "square.and.pencil", width: 30, height: 30))
        .navigationBarTitle(blocker.name, displayMode: .inline)
        
        

    }
}


struct UIDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let blocker1: BlockerModel = BlockerModel(name: "식비", image: "eat-blocker", budget: 600000, period: .monthly, resetDate: DateComponents(day:1), spent: 300000, startDate: nil, endDate: nil, histories: [])
        
        NavigationView {
            UIDetail(blocker: blocker1)
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
