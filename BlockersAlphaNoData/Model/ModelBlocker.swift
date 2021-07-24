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
    var resetDate: DateComponents?
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

enum CustomWeekdays: String, CaseIterable, Identifiable {
    case 일요일, 월요일, 화요일, 수요일, 목요일, 금요일, 토요일 
    var id: String { self.rawValue }
}

let weekdays2int: [String:Int] = ["일요일" : 1,
                              "월요일" : 2,
                              "화요일" : 3,
                              "수요일" : 4,
                              "목요일" : 5,
                              "금요일" : 6,
                              "토요일" : 7]

let customDays: [String] = ["매월 1 일", "매월 말 일"] + (2...31).map { "\($0) 일" }

var days2int1: [String:Int] = ["매월 1 일" : 1,
                              "매월 말 일" : 31]

var days2int2: [String:Int] = Dictionary(uniqueKeysWithValues: zip((2...31).map { "\($0) 일" }, 2...31))

let days2int = days2int1.merging(days2int2) { $1 }

