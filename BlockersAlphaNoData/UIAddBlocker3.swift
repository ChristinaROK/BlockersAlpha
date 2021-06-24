//
//  UIAddBlocker3.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/24.
//

import SwiftUI

struct UIAddBlocker3: View {
    
    @State private var amount = "0 ￦"
    
    // TODO: 1. ui navigation bar 모든 뷰에 생성 (pre, next button) / 2. customized keyboard 개발
    var body: some View {
        
        VStack {
            CustomText(text: "관리할 예산 블럭의 총 금액을 알려주세요.", size: 20, weight: .semibold, design: .default, color: .black)
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green)
                    .frame(width: 350, height: 50, alignment: .center)
                    .opacity(0.6)
                
                HStack {
                    TextField("Amount", text: $amount)
                        .offset(x: 40, y: 2)
                    
                    Button {
                        // numeric keypad
                    } label: {
                        CustomSFImage(imageName: "keyboard.chevron.compact.down", width: 20, height: 20, corner: 0.2)
                    }
                    .offset(x: -40, y: 2)
                }
            }
        }
    }
}

struct UIAddBlocker3_Previews: PreviewProvider {
    static var previews: some View {
        UIAddBlocker3()
    }
}
