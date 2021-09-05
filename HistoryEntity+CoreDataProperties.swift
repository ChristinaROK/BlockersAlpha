//
//  HistoryEntity+CoreDataProperties.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/09/05.
//
//

import Foundation
import CoreData


extension HistoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryEntity> {
        return NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    }

    @NSManaged public var date: Date
    @NSManaged public var earn: Float
    @NSManaged public var notes: String?
    @NSManaged public var spend: Float
    @NSManaged public var blocker: BlockerEntity?

}

extension HistoryEntity : Identifiable {

}
