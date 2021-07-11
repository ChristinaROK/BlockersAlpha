//
//  ModelBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import Foundation

struct Blocker: Identifiable {
    let id = UUID()
    let name: String
    var image: String
    var dDay: String // todo: move this property to ModelUser
    var rawBalance: Float // todo: move this property to ModelUser
    lazy var balance: String = rawBalance.currencyRepresentation
    
}

struct BlockerList {
    
    
    static var mainBlockerList = [
        Blocker(name: "Eat",
                image: "eat-blocker",
                dDay: "d-14",
                rawBalance: 24500),
        
        Blocker(name: "Shop",
                image: "shop-blocker",
                dDay: "d-14",
                rawBalance: 50000),
        
        Blocker(name: "Cafe",
                image: "cafe-blocker",
                dDay: "d-2",
                rawBalance: 20000),
        
        Blocker(name: "Workout",
                image: "workout-blocker",
                dDay: "d-30",
                rawBalance: 300000),

    ]
}
