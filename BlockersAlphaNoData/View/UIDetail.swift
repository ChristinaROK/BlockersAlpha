//
//  UIDetail.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIDetail: View {
    
    var blocker: BlockerModel
    
    var body: some View {
        Text("\(blocker.name)")
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
