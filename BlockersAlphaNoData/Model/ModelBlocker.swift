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
    var name: String
    var image : String
    var budget: Float
    var period: BlockerPeriodModel? // Weekly / Monthly / Yearly
    var resetDate: DateComponents?
    var spent: Float?
    var startDate: Date?
    var endDate: Date?
    var histories: [BlockerHistoryModel]
    // Computed Property
    var currentBudget: Float { // desc: 현재 주기의 남은 예산 금액
        get {
            if let currentSpent = self.spent {
                return self.budget - currentSpent
            } else {
                return self.budget
            }
        }
    }
    
    var nextDate: Date { // desc: 시험용 변수. 향후 삭제할 예정
        get {
            if let component = self.resetDate {
                let cal = Calendar.current
                let closestNextDate = cal.nextDate(after: Date(), matching: component, matchingPolicy: .previousTimePreservingSmallerComponents)
                return closestNextDate ?? Date()
            } else {
                return Date()
            }
            
        }
    }
    
    var dDay: Int { // desc: 예산 종료일까지 남은 일자 수
        get {
            let cal = Calendar.current
            if let component = self.resetDate {
                let closestNextDate: Date = cal.nextDate(after: Date(), matching: component, matchingPolicy: .previousTimePreservingSmallerComponents) ?? Date()
                let closestNextDateZeroset: Date = cal.date(bySettingHour: 0, minute: 0, second: 0, of: closestNextDate)!
                let todayZeroset: Date = cal.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
                let offSet: DateComponents = cal.dateComponents([.day], from: todayZeroset, to: closestNextDateZeroset)
                return offSet.day ?? 0
            } else {
                let offSet: DateComponents = cal.dateComponents([.day], from: self.startDate ?? Date(), to: self.endDate ?? Date())
                return offSet.day ?? 0
            }
        }
    }
    
    var dTime: Int { // desc: 오늘자 예산 종료일까지 남은 시간
        get {
            let cal = Calendar.current
            let todayStartDate = cal.startOfDay(for: Date())
            let tomorrowStartDate = cal.date(byAdding: .day, value: 1, to: todayStartDate)
            let offSet: DateComponents = cal.dateComponents([.hour], from: Date(), to: tomorrowStartDate ?? Date())
            return offSet.hour ?? 0
        }
    }
    
    var todayBudget: Float { // desc: 오늘자 사용 가능한(남은) 예산 금액
        get {
            return self.currentBudget/Float(self.dDay == 0 ? 1 : self.dDay)
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

//let customDays: [String] = ["1 일", "말 일"] + (2...31).map { "\($0) 일" }
let customDates: [String] = (1...31).map { "\($0) 일" }

let customMonth: [String] = (1...12).map { "\($0) 월" }

/*
 Model - Custom date2value Mapper
 */

let weekdays2int: [String:Int] = ["일요일" : 1,
                              "월요일" : 2,
                              "화요일" : 3,
                              "수요일" : 4,
                              "목요일" : 5,
                              "금요일" : 6,
                              "토요일" : 7]

//var days2int1: [String:Int] = ["1 일" : 1, "말 일" : 31]
//var days2int2: [String:Int] = Dictionary(uniqueKeysWithValues: zip((2...31).map { "\($0) 일" }, 2...31))
//let days2int = days2int1.merging(days2int2) { $1 }

let days2int: [String:Int] = Dictionary(uniqueKeysWithValues: zip(customDates, (1...31)))

let month2int: [String:Int] = Dictionary(uniqueKeysWithValues: zip(customMonth, (1...12)))



