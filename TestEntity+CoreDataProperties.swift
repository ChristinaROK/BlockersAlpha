//
//  TestEntity+CoreDataProperties.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/09/04.
//
//

import Foundation
import CoreData


extension TestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestEntity> {
        return NSFetchRequest<TestEntity>(entityName: "TestEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var resetDate: DateComponents?

}

extension TestEntity : Identifiable {

}
