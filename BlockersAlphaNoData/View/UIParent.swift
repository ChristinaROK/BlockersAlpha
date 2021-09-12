//
//  UIParent.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/08/08.
//

import SwiftUI

struct UIParent: View {
    
    @EnvironmentObject var blockerViewModel : BlockerCoreDataViewModel
    @EnvironmentObject var imageViewModel : ImageCoreDataViewModel
    @EnvironmentObject var newBlockerModel : NewBlockerCoreDataViewModel
    
    var body: some View {
        TabView {
            // 1st
            NavigationView{
                UIMain()
            }
            .environmentObject(blockerViewModel)
            .environmentObject(imageViewModel)
            .environmentObject(newBlockerModel)
            .tabItem {
                Image(systemName: "house")
                Text("MAIN")
            }
            
            
            
            // 2nd
            UIBlockerLevel()
                .tabItem {
                    Image(systemName: "cart.circle")
                    Text("SHOP")
                    
                    // custom image size  조정이 불가능
                    //CustomAssetsImage(imageName: "icon-shop-blocker", width: 1, height: 1, corner: 0)
                }
            
            // 3rd
            UIConfig()
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("SETTING")
                }
            
        }
    }
}

struct UIParent_Previews: PreviewProvider {
    static var previews: some View {
        UIParent()
            .environmentObject(BlockerCoreDataViewModel())
            .environmentObject(ImageCoreDataViewModel())
            .environmentObject(NewBlockerCoreDataViewModel())
    }
}
