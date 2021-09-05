//
//  BlockerEntity+CoreDataProperties.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/09/05.
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
    @NSManaged public var resetDate: DateComponents?
    @NSManaged public var spent: Float
    @NSManaged public var startDate: Date?
    @NSManaged public var histories: NSSet?
    @NSManaged public var image: ImageEntity
    
//    var currentHistories: [HistoryEntity] {
//
//        // filter DATE
//        let predicate = NSPredicate(format: "", <#T##args: CVarArg...##CVarArg#>)
//
//        return Array(histories?.filtered(using: predicate)) as! [HistoryEntity]
//    }
    
    var currentBudget: Float {
        get {
            var newBudget = budget + earned - spent // 이월 잔액 계산
            
            // TODO : histories -> currentHistories로 변경
            if let allHistories = histories?.allObjects as? [HistoryEntity] {
                
                for history in allHistories {
                    let newOffset = history.earn - history.spend
                    newBudget += newOffset
                }
            }
            
            return newBudget
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
