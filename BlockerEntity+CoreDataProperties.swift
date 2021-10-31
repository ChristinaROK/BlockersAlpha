//
//  BlockerEntity+CoreDataProperties.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/09/11.
//
//

import Foundation
import CoreData


extension BlockerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BlockerEntity> {
        return NSFetchRequest<BlockerEntity>(entityName: "BlockerEntity")
    }

    @NSManaged public var budget: Float
    @NSManaged public var earned: Float
    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var period: String?
    @NSManaged public var spent: Float
    @NSManaged public var startDate: Date?
    @NSManaged public var resetDay: Int16
    @NSManaged public var resetMonth: Int16
    @NSManaged public var resetWeekday: Int16
    @NSManaged public var histories: NSSet?
    @NSManaged public var image: ImageEntity
    
    // TODO: histories predicate로 spend & earn 가져오기
    var currentBudget: Float { // desc : 기간 내 남은 예산
        get {
            return self.budget + self.earned - spent + self.periodEarn - self.periodSpend
        }
    }
    
    var currentBudgetPerBudget: Float { // desc : 전체 예산에서 남은 예산이 차지하는 비율 (=HP)
        get {
            return self.currentBudget / self.budget
        }
    }
    
    var customCalendar: Calendar { // dese : Helping Property
        get {
            var calendar = Calendar.current
            calendar.locale = Locale.init(identifier: "ko_KR") //TODO: hard coding 제거
            calendar.timeZone = TimeZone.init(identifier: "Asia/Seoul")! //TODO: hard coding 제거
            return calendar
        }
    }
    
    var todayComponent: DateComponents { // desc : Helping Property
        get {
            let calendar = customCalendar
            let todayComponent = calendar.dateComponents([.year, .month, .day],
                                                         from: Date())
            return todayComponent
        }
    }
    
    var periodStartDate: Date { // desc: [반복 예산] 예산 시작일
        get {
            
            let calendar = self.customCalendar
            let todayMidnight = calendar.date(bySettingHour: 23, // endDate 계산하는 기준 날짜를 오늘밤 자정으로 설정
                                              minute: 59,
                                              second: 59,
                                              of: Date())!
            
            if self.period == "weekly" {
                if self.resetWeekday != 0 {
                    return calendar.nextDate(after: todayMidnight,
                                             matching: DateComponents(hour: 0,
                                                                      minute:0,
                                                                      second:0,
                                                                      weekday: Int(self.resetWeekday)),
                                             matchingPolicy: .previousTimePreservingSmallerComponents,
                                             direction: .backward)
                    ?? Date()
                } else {
                    return Date()
                }
            } else if self.period == "monthly" {
                if self.resetDay != 0 {
                    return calendar.nextDate(after: todayMidnight,
                                             matching: DateComponents(day:Int(self.resetDay),
                                                                      hour: 0,
                                                                       minute:0,
                                                                       second:0),
                                             matchingPolicy: .previousTimePreservingSmallerComponents,
                                             direction: .backward)
                    ?? Date()
                } else {
                    return Date()
                }
            } else if self.period == "yearly" {
                if (self.resetMonth != 0) && (self.resetDay != 0) {
                    return calendar.nextDate(after: todayMidnight,
                                             matching: DateComponents(month: Int(self.resetMonth),
                                                                      day: Int(self.resetDay),
                                                                      hour: 0,
                                                                       minute:0,
                                                                       second:0),
                                             matchingPolicy: .previousTimePreservingSmallerComponents,
                                             direction: .backward)
                    ?? Date()
                } else {
                    return Date()
                }
            } else {
                return Date()
            }
        }
    }
    
    var periodEndDate: Date { // desc: [반복 예산] 예산 종료일 -> spent & earned 갱신
        get {
            
            let calendar = self.customCalendar
            let todayMidnight = calendar.date(bySettingHour: 23, // endDate 계산하는 기준 날짜를 오늘밤 자정으로 설정
                                              minute: 59,
                                              second: 59,
                                              of: Date())!
            
            if self.period == "weekly" {
                if self.resetWeekday != 0 {
                    return calendar.nextDate(after: todayMidnight,
                                             matching: DateComponents(weekday: Int(self.resetWeekday)),
                                             matchingPolicy: .previousTimePreservingSmallerComponents)
                    ?? Date()
                } else {
                    return Date()
                }
            } else if self.period == "monthly" {
                if self.resetDay != 0 {
                    return calendar.nextDate(after: todayMidnight,
                                             matching: DateComponents(day:Int(self.resetDay)),
                                             matchingPolicy: .previousTimePreservingSmallerComponents)
                    ?? Date()
                } else {
                    return Date()
                }
            } else if self.period == "yearly" {
                if (self.resetMonth != 0) && (self.resetDay != 0) {
                    return calendar.nextDate(after: todayMidnight,
                                             matching: DateComponents(month: Int(self.resetMonth),
                                                                      day: Int(self.resetDay)), matchingPolicy: .previousTimePreservingSmallerComponents)
                    ?? Date()
                } else {
                    return Date()
                }
            } else {
                return Date()
            }
        }
    }
    
    var periodDayCnt: Int { // desc : 예산 기간 (days)
        get {
            
            let calendar = self.customCalendar
            let diff = calendar.dateComponents([.day], from: self.periodStartDate, to: self.periodEndDate)
            return diff.day!
        }
    }
    
    var dDay: Int { // desc : 예산 종료까지 남은 일자
        get {

            let calendar = self.customCalendar
            let todayComponent = self.todayComponent
            
            var output: Int?
            
            // 1. 주기성 예산
            if self.period != nil {
//                if period == "weekly" {
//                    // 1-1. 일주일 주기 예산
//                    if self.resetWeekday != 0 {
//                        closestNextDate = calendar.nextDate(after: todayFullSet,
//                                                                matching: DateComponents(hour:23,
//                                                                            minute: 59,
//                                                                            second: 59,
//                                                                            weekday: Int(self.resetWeekday)),
//                                                                matchingPolicy: .previousTimePreservingSmallerComponents)
//                    }
//                } else if period == "monthly" {
//                    // 1-2. 월 주기 예산
//                    if self.resetDay != 0 {
//                        closestNextDate = calendar.nextDate(after: todayFullSet,
//                                                                matching: DateComponents(
//                                                                    day: Int(self.resetDay),
//                                                                    hour:23,
//                                                                    minute: 59,
//                                                                    second: 59
//                                                                    ),
//                                                                matchingPolicy: .previousTimePreservingSmallerComponents)
//                    }
//                } else if period == "yearly"{
//                    // 1-3. 년 주기 예산
//                    if (self.resetDay != 0) && (self.resetMonth != 0) {
//                        closestNextDate = calendar.nextDate(after: todayFullSet,
//                                                                matching: DateComponents(
//                                                                    month: Int(self.resetMonth),
//                                                                    day: Int(self.resetDay),
//                                                                    hour:23,
//                                                                    minute: 59,
//                                                                    second: 59
//                                                                    ),
//                                                                matchingPolicy: .previousTimePreservingSmallerComponents)
//                    }
//
//                }
                
//                if let nextDate = self.periodEndDate {
                
                let nextDayComp = calendar.dateComponents([.year, .month, .day], from: self.periodEndDate)
                let offSet = calendar.dateComponents([.day],
                                                     from: DateComponents(
                                                        year:todayComponent.year,
                                                        month: todayComponent.month,
                                                        day: todayComponent.day
                                                     ),
                                                     to: DateComponents(
                                                        year:nextDayComp.year,
                                                      month:nextDayComp.month,
                                                      day:nextDayComp.day)
                )
                output=offSet.day
//                }
            } else {
                // 2. 일회성 예산
                if let start = self.startDate, let end = self.endDate {
                    let startComp = calendar.dateComponents([.year, .month, .day], from: start)
                    
                    let endComp = calendar.dateComponents([.year, .month, .day], from: end)
                    
                    let offSet = calendar.dateComponents([.day],
                                                        from: DateComponents(
                                                           year:startComp.year,
                                                           month: startComp.month,
                                                           day: startComp.day
                                                        ),
                                                        to: DateComponents(
                                                           year: endComp.year,
                                                         month:endComp.month,
                                                         day:endComp.day)
                    )
                    
                    output = offSet.day
                }
            }
            
            return output ?? 0
        }
    }
    
    var dTime: Int { // desc : 예산 종료까지 남은 시간
        get {
            
            let maxHour = 24
            let calendar = customCalendar
            let currentHour = calendar.dateComponents([.hour], from: Date()).hour ?? maxHour
            
            
            return maxHour - currentHour
        }
    }
    
    var todayBudget: Float { // desc: 오늘 사용 가능한(남은) 예산 (temp: 예산이 음수인 경우는 그대로 출력)
        get {
            if self.currentBudget >= 0 {
                return self.currentBudget / Float(self.dDay == 0 ? 1 : self.dDay)
            } else {
                return self.currentBudget
            }
        }
    }
    
    var status: String { // desc : 전체 예산 상태. View에서 good이면 웃는 블로커 / bad면 화난 블로커를 보여줌
        get {
            return self.currentBudgetPerBudget >= (Float(self.dDay - 1) / Float(self.periodDayCnt)) ? "good" : "bad"
        }
    }
    
    var periodHistoryArray: Array<HistoryEntity> {
        get {
            var periodArray: Array<HistoryEntity> = []
            
            for history in Array(self.histories as? Set<HistoryEntity> ?? []) {
                if (history.date >= self.periodStartDate) && (history.date < self.periodEndDate) {
                    periodArray.append(history)
                }
            }
            return periodArray
        }
    }
    
    var periodSpend: Float {
        get {
            var total: Float = 0
            
            for history in self.periodHistoryArray {
                if history.spend > 0 {
                    total+=history.spend
                }
            }
            return total
        }
    }

    var periodEarn: Float {
        get {
            var total: Float = 0
            
            for history in self.periodHistoryArray {
                if history.earn > 0 {
                    total+=history.earn
                }
            }
            return total
        }
    }
    
    var todaySpend: Float {
        get {
            let calendar = self.customCalendar
            let todayComponent = self.todayComponent
            var total: Float = 0
            
            for history in self.periodHistoryArray {
                if calendar.dateComponents([.year,.month,.day], from: history.date) == todayComponent {
                    if history.spend > 0 {
                        total += history.spend
                    }
                    
                }
            }
            
            return total
        }
    }
    
    var todayStatus: String {
        get {
            return self.todaySpend > self.todayBudget ? "bad" : "good"
        }
    }
    
    var todayBudgetPerBudget: Float { // desc : 전체 예산에서 남은 예산이 차지하는 비율 (=HP)
        get {
            return (self.todayBudget - self.todaySpend) / self.todayBudget
        }
    }

    
    
    

}

// MARK: Generated accessors for histories
extension BlockerEntity {

    @objc(addHistoriesObject:)
    @NSManaged public func addToHistories(_ value: HistoryEntity)

    @objc(removeHistoriesObject:)
    @NSManaged public func removeFromHistories(_ value: HistoryEntity)

    @objc(addHistories:)
    @NSManaged public func addToHistories(_ values: NSSet)

    @objc(removeHistories:)
    @NSManaged public func removeFromHistories(_ values: NSSet)

}

extension BlockerEntity : Identifiable {

}
