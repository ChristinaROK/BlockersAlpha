//
//  UIAddBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI


struct UIAddBlocker1: View {
    
    var body: some View {
        NavigationView {
            VStack {
                CustomText(text: "예산을 지켜줄 블로커를 선택해 주세요", size: 20, weight: .semibold, design: .default, color: .white)
                    .padding(.all, 20)
                    .background(Color.green.opacity(0.8))
                
                VStack {
                    HStack {
                        CustomSFImage(imageName: "person.fill.questionmark", width: 30, height: 30, corner: 0)
                            .padding(.all, 70)
                        
                        CustomSFImage(imageName: "person.fill.questionmark", width: 30, height: 30, corner: 0)
                            .padding(.all, 70)
                    }
                    
                    HStack {
                        CustomSFImage(imageName: "person.fill.questionmark", width: 30, height: 30, corner: 0)
                            .padding(.all, 70)
                        
                        CustomSFImage(imageName: "person.fill.questionmark", width: 30, height: 30, corner: 0)
                            .padding(.all, 70)
                    }
                }
                
                NavigationLink(
                    destination: UIAddBlocker2(),
                    label: {
                        CustomText(text: "블로커 선택하기", size: 15, weight: .semibold, design: .default, color: .white)
                            .padding(.all, 10)
                            .background(Color.green.opacity(0.8))
                    })
            }
        }
    }
}

struct UIAddBlocker_Previews: PreviewProvider {
    static var previews: some View {
        UIAddBlocker1()
    }
}
