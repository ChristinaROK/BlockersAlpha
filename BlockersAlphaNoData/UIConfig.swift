//
//  UILevel.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/13.
//

import SwiftUI

struct UIConfig: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            VStack {}
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            
                            CustomSFImage(imageName: "xmark.circle", width: 30, height: 30, corner: 0)
                                
                        }
                    }
                }
        }
    }
}


struct UILevel_Previews: PreviewProvider {
    static var previews: some View {
        UIConfig()
    }
}
