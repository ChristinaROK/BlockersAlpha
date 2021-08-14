//
//  UIStats.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/08/15.
//

import SwiftUI

struct UIStats: View {
    var body: some View {
        ZStack {
            Color("peripheralOlive")
                .ignoresSafeArea()
            Text("Total Stats")
        }
    }
}

struct UIStats_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UIStats()
        }
    }
}
