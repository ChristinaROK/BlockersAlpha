//
//  ModelBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import Foundation

struct BlockerModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let image : String
    var budget: Float
    var period: String? // Weekly / Monthly / Yearly
    var resetDate: String? // Monday / 27 / 27, January
    var spent: Float?
    var startDate: Date?
    var endDate: Date?
    var histories: [BlockerHistoryModel]
    
    func getCurrentBudget() -> Float {
        if let currentSpent = self.spent {
            return self.budget - currentSpent
        } else {
            return self.budget
        }
    }
}

struct BlockerHistoryModel: Hashable {
    let date: String
    let spent: Float
    let earn: Float
    let memo: String
}

struct BlockerImageModel: Identifiable {
    let id: String = UUID().uuidString
    let image: String
}
