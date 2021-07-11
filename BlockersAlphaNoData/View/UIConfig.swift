//
//  UILevel.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/13.
//

import SwiftUI

struct UIConfig: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var localIndex = 0
    let localOptions: [String] = ["Korean (￦)", "English ($)"]
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    // TODO: picker 선택값 적용을 위해 .onChange modifier 사용할 것
                    Section(header: Text("currency")) {
                        Picker(selection: $localIndex,
                               label: Text("Currency"),
                               content: {
                                ForEach(localOptions.indices) {
                                    Text(self.localOptions[$0]).tag($0)
                                }
                               })
                            .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
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
