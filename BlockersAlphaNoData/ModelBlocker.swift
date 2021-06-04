//
//  ModelBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct Blocker: Identifiable {
    let id = UUID()
    let name: String
    var image: String
    var dDay: String // todo: move this property to ModelUser
    var balance: Float // todo: move this property to ModelUser
}

struct BlockerList {
    
    static let mainBlockerList = [
        Blocker(name: "Eat",
                image: "eat-blocker",
                dDay: "d-14",
                balance: 24500),
        
        Blocker(name: "Shop",
                image: "shop-blocker",
                dDay: "d-14",
                balance: 50000)
    ]
}
