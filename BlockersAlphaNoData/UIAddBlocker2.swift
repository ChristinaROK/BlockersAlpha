//
//  UIAddBlocker2.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/23.
//

import SwiftUI

struct UIAddBlocker2: View {
    
    @State private var name = ""
    
    var body: some View {
        VStack {
            CustomText(text: "예산 블럭의 이름을 작성해주세요.", size: 20, weight: .semibold, design: .default, color: .black)
            
            ZStack {
                // # TODO: replace text to shape with specified size
                Text("                                                            ")
                    .padding(.all, 20)
                    .background(Color.green)
                    .opacity(0.4)
                
                TextField("Blocker Name: ", text: $name)
                    .offset(x: 50, y: 0)
            }
            
            NavigationLink(
                destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                label: {
                    CustomText(text: "다음", size: 15, weight: .semibold, design: .default, color: .white)
                        .padding(.all, 10)
                        .background(Color.green.opacity(0.8))
                })

            
        }
    }
}

struct UIAddBlocker2_Previews: PreviewProvider {
    static var previews: some View {
        UIAddBlocker2()
    }
}
