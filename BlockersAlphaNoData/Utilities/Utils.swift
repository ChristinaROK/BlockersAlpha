//
//  Utils.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//
// Collection of customized structs which contains more than 2 modifiers

import SwiftUI

struct CustomAssetsImage: View {
    // Image View with from assets
    var imageName: String
    var width: CGFloat?
    var height: CGFloat?
    var corner: CGFloat?
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(corner!)
            .scaledToFit()
    }
}

struct CustomSFImage: View {
    // Image View with SF image name
    var imageName: String
    var width: CGFloat?
    var height: CGFloat?
    var corner: CGFloat?
    
    var body: some View {
        Image(systemName: imageName)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(corner!)
            .scaledToFit()
    }
}

struct CustomText: View {
    // Text View
    var text: String
    var size: CGFloat
    var weight: Font.Weight
    var design: Font.Design
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: weight, design: design))
            .foregroundColor(color)
    }
}

struct Utils_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(text: "Today", size: 20, weight: .bold, design: .serif, color: .black)
    }
}


