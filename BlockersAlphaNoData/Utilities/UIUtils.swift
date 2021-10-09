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
//            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(corner!)
            .scaledToFit()
    }
}

struct CustomSFImage: View {
    // Image View with SF image name
    var imageName: String
    var renderMode: Image.TemplateRenderingMode = .original
    var width: CGFloat
    var height: CGFloat
    var corner: CGFloat = 0
    var color: Color = Color.black
    
    var body: some View {
        Image(systemName: imageName)
            .renderingMode(renderMode)
            .resizable()
            .foregroundColor(color)
            //.aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(corner)
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

struct UIUtils: PreviewProvider {
    static var previews: some View {
        //CustomText(text: "Today", size: 20, weight: .bold, design: .serif, color: .black)
        //CustomSFImage(imageName: "bag.circle.fill", renderMode: .template, width: 100, height: 100, color: Color.red)
        CustomSFImage(imageName: "person.crop.square.fill", renderMode: .template, width: 70, height: 70, color: Color.blockerOrange)
    }
}



