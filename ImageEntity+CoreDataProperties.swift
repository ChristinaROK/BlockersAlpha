//
//  ImageEntity+CoreDataProperties.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/09/05.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var blockers: NSSet?

}

// MARK: Generated accessors for blockers
extension ImageEntity {

    @objc(addBlockersObject:)
    @NSManaged public func addToBlockers(_ value: BlockerEntity)

    @objc(removeBlockersObject:)
    @NSManaged public func removeFromBlockers(_ value: BlockerEntity)

    @objc(addBlockers:)
    @NSManaged public func addToBlockers(_ values: NSSet)

    @objc(removeBlockers:)
    @NSManaged public func removeFromBlockers(_ values: NSSet)

}

extension ImageEntity : Identifiable {

}
