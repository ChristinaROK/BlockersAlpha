//
//  BlockersAlphaNoDataApp.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

@main
struct BlockersAlphaNoDataApp: App {
    var body: some Scene {
        WindowGroup {
            ////            NavigationView {
            ////                UIMain()
            ////            }
            UIParent()
            //.navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(BlockerCoreDataViewModel())
            .environmentObject(ImageCoreDataViewModel())
            .environmentObject(NewBlockerCoreDataViewModel())
            
//            Test2()
//                .environmentObject(BlockerCoreDataViewModel())
//                .environmentObject(ImageCoreDataViewModel())
        }
    }
}
