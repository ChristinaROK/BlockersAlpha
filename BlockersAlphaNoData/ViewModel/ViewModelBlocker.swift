//
//  ViewModelBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/07/18.
//

import Foundation

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
        let newBlockers = [
            BlockerModel(name: "식비", image: "eat-blocker", budget: 600000, period: .weekly, resetDate: "1", spent: 300000, startDate: nil, endDate: nil, histories: []),
            BlockerModel(name: "쇼핑", image: "shop-blocker", budget: 400000, period: nil, resetDate: nil, spent: nil, startDate: Date(), endDate: Date(), histories: [])
        ]
        
        currentBlockers.append(contentsOf: newBlockers)
        
    }
    
    func addBlocker() {
        
    }
    
    
    func deleteBlocker(indexSet: IndexSet) {
        currentBlockers.remove(atOffsets: indexSet)
    }
    
    func moveBlocker(indices: IndexSet, newOffset: Int) {
        currentBlockers.move(fromOffsets: indices, toOffset: newOffset)
    }
    
}
