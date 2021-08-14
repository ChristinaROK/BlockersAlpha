//
//  UIDailyStats.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/08/15.
//

import SwiftUI

struct UIDailyStats: View {
    var body: some View {
        ZStack {
            Color("peripheralOlive")
                .ignoresSafeArea()
            Text("Daily Stats")
        }
    }
}

struct UIDailyStats_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UIDailyStats()
        }
    }
}
