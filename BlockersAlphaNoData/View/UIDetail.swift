//
//  UIDetail.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIDetail: View {
    
    @State var isFirst: Bool = false
    var blocker: BlockerModel
    
    var body: some View {
        
        if isFirst {
            UIFirstView()
                .transition(.slide)
        } else {
            UISecondView(isFirst: $isFirst)
        }
    }
}

struct UIFirstView: View {
    var body: some View {
        VStack {
            Text("First View")
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
                .frame(width: 200, height: 200)
        }
        
            
    }
}

struct UISecondView: View {
    
    @Binding var isFirst: Bool
    
    var body: some View {
        VStack {
        Text("Second View")
        Button(action: {
            withAnimation {
                isFirst.toggle()
            }
            
        }, label: {
            Text("ClickMe")
        })
        }
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
