//
//  UILevel.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/13.
//

import SwiftUI

// TODO: 1. sheetopening 변수를 받아서 toggle 하기 2. close button 만들기
struct UILevel: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button("Press to dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
//        .font(.title)
//        .padding()
//        .background(Color.black)
    }
}


struct UILevel_Previews: PreviewProvider {
    static var previews: some View {
        UILevel()
    }
}
