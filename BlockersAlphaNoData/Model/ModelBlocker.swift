//
//  ModelBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import Foundation

/*
Model - Blocker
 */

struct BlockerModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let image : String
    var budget: Float
    var period: BlockerPeriodModel? // Weekly / Monthly / Yearly
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

enum BlockerPeriodModel: String, CaseIterable, Equatable {
    case weekly ,monthly, yearly
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

/*
 Model - Custom Dates
 */

enum CustomDays: String, CaseIterable, Identifiable {
    case 월요일 , 화요일, 수요일, 목요일, 금요일, 토요일, 일요일
    var id: String { self.rawValue }
}
