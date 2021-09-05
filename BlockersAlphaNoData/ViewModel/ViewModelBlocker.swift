//
//  ViewModelBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/07/18.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager() // Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "BlockerContainer")
        container.loadPersistentStores { (des, error) in
            if let error = error {
                print("ERROR loading core data \(error)")
            }
        }
        
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("SUCESS save done")
        } catch let error {
            print("ERROR saving Core Data \(error)")
        }
    }
    
}

class BlockerCoreDataViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var currentBlockers: [BlockerEntity] = []
    
    init() {
        getBlockerEntity()
    }
    
    func getBlockerEntity() {
        let request = NSFetchRequest<BlockerEntity>(entityName: "BlockerEntity")
        
        do {
            currentBlockers = try manager.context.fetch(request)
            print("SUCESS fetching Core Data")
        } catch let error {
            print("Error fetching Core Data \(error)")
        }
    }
    
    func addBlockerEntity(blocker: BlockerCoreDataModel) {
        let newBlocker = BlockerEntity(context: manager.context)

        newBlocker.id = blocker.id
        newBlocker.name = blocker.name
        newBlocker.budget = blocker.budget
        newBlocker.period = blocker.period?.rawValue ?? "" // String
        newBlocker.resetDate = blocker.resetDate
        newBlocker.startDate = blocker.startDate
        newBlocker.endDate = blocker.endDate
        newBlocker.spent = blocker.spent ?? 0
        newBlocker.earned = blocker.earned ?? 0
        newBlocker.image = blocker.imageEntity
        
        save()
    }
    
    func save() {
        currentBlockers.removeAll()
        
        self.manager.save() // CoreDate에 저장
        self.getBlockerEntity() // ViewModel object 업데이트
    }
}


class ImageCoreDataViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var currentImages: [ImageEntity] = []
    
    init() {
        getImageEntity()
        addDefaultImage()
    }
    
    func getImageEntity() {
        let request = NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
        
        do {
            currentImages = try manager.context.fetch(request)
            print("SUCESS fetching Core Data")
        } catch let error {
            print("Error fetching Core Data \(error)")
        }
    }
    
    func addDefaultImage() {
        let defaultImageNames = ["eat-blocker", "cafe-blocker", "shop-blocker", "workout-blocker"]
        
        if currentImages.count == 0 {
            
            print("Adding Default Images to Core Data")
            
            for name in defaultImageNames {
                let newImage = ImageEntity(context: manager.context)
                newImage.id = UUID()
                newImage.name = name
            }
            
            save()
        }
    }
    
    func deleteAllImage() {
        
        for image in currentImages {
            manager.context.delete(image)
            print("Delete \(image.name)")
        }
        
        save()
    }
    
    
    func save() {
        currentImages.removeAll()
        
        self.manager.save() // CoreDate에 저장
        self.getImageEntity()
    }
}

class ImageViewModel: ObservableObject {
    
    @Published var currentImages : [BlockerImageModel] = []
    
    init() {
        getDefaultImage()
    }
    
    func getDefaultImage() {
        let newImages = [
            BlockerImageModel(image: "eat-blocker"),
            BlockerImageModel(image: "cafe-blocker"),
            BlockerImageModel(image: "shop-blocker"),
            BlockerImageModel(image: "workout-blocker")
        ]
        
        currentImages.append(contentsOf: newImages)
    }
    
    func addImage() {
        
    }
}


class BlockerViewModel: ObservableObject {
    
    @Published var currentBlockers : [BlockerModel] = []
    
    init() {
        getBlocker()
    }
    
    func getBlocker() {
        let newBlockers: [BlockerModel] = [
            BlockerModel(name: "식비", image: "eat-blocker", budget: 600000, period: .weekly, resetDate: DateComponents(weekday:1), spent: 300000, startDate: nil, endDate: nil, histories: []),
            BlockerModel(name: "쇼핑", image: "shop-blocker", budget: 400000, period: nil, resetDate: nil, spent: nil, startDate: Date(), endDate: Date(), histories: [])
        ]
        
        currentBlockers.append(contentsOf: newBlockers)
        
    }
    
//    func addBlocker() {
//        
//    }
    
    
    func deleteBlocker(indexSet: IndexSet) {
        currentBlockers.remove(atOffsets: indexSet)
    }
    
    func moveBlocker(indices: IndexSet, newOffset: Int) {
        currentBlockers.move(fromOffsets: indices, toOffset: newOffset)
    }
    
}

class NewBlockerViewModel: ObservableObject {
    
    @Published var blocker: BlockerModel
    
    init() {
        self.blocker = BlockerModel(name: "", image: "", budget: 0, histories: [])
        //self.blocker = BlockerModel(name: "eating", image: "eat-blocker", budget: 200000, histories: [])
    }
}
