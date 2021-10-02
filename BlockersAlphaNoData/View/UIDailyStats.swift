//
//  UIDailyStats.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/08/15.
//

import SwiftUI

struct UIDailyStats: View {
    
    var blocker: BlockerEntity
    
    var body: some View {
        
        ZStack {
            Color("peripheralOlive")
                .ignoresSafeArea()
            Text("Daily Stats")
            
            if blocker.histories != nil {
                List {
                    ForEach(Array(blocker.histories as? Set<HistoryEntity> ?? []), id: \.self) { history in
                        Text("Date : \(history.date)")
                        Text("수입 : \(history.earn)")
                        Text("지출 : \(history.spend)")
                        Text("메모 : 000\(history.notes ?? "")")
                    }
                }
            }
            
        }
    }
}

//struct UIDailyStats_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            UIDailyStats()
//        }
//    }
//}
