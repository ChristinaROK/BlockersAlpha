//
//  UIEditBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/11/04.
//

import SwiftUI

struct UIEditBlocker: View {
    
    var blocker : temptBlockerModel
    @State var name: String
    @State var budget: String
    
    init(blocker: temptBlockerModel) {
        self.blocker = blocker // [TODO] change into CoreDataBlocker
        _name = State(initialValue: self.blocker.name)
        _budget = State(initialValue: "\(self.blocker.budget)")
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                CustomAssetsImage(imageName: blocker.image, width: 200, height: 150, corner: 0)
                
                // [TODO] button
                
                Form{
                    HStack{
                        CustomText(text: "이름", size: 20, weight: .bold, design: .default, color: .black)
                        
                        if #available(iOS 15.0, *) {
                            TextField("이름", text: $name, prompt: Text("새로운 예산 이름"))
                        } else {
                            // Fallback on earlier versions
                            TextField("새로운 예산 이름", text: $name)
                        }
                    }
                    
                    HStack{
                        CustomText(text: "예산 금액", size: 20, weight: .bold, design: .default, color: .black)
                        
                        if #available(iOS 15.0, *) {
                            TextField("금액", text: $budget, prompt: Text("새로운 예산 금액"))
                        } else {
                            // Fallback on earlier versions
                            TextField("새로운 예산 금액", text: $budget)
                        }
                    }

                }

            }
        }
        
    }
}

struct UIEditBlocker_Previews: PreviewProvider {
    static var previews: some View {
        UIEditBlocker(
            blocker: temptBlockerModel(name: "식비", image: "basic-blocker", budget: 10000, period: .weekly, resetDate: DateComponents(weekday:1), startDate: nil, endDate: nil)
        )
    }
}

struct temptBlockerModel: Identifiable {
    let id: UUID = UUID()
    var name: String
    var image: String
    var budget: Float
    var period: BlockerPeriodModel?
    var resetDate: DateComponents?
    var startDate: Date?
    var endDate: Date?
}
