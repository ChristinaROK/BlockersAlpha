//
//  Test2.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/09/05.
//

import SwiftUI

struct Test2: View {
    
    @EnvironmentObject var imageVM : ImageCoreDataViewModel
    @EnvironmentObject var blockerVM : BlockerCoreDataViewModel
    
    var newBlocker : BlockerCoreDataModel {
        get {
            return BlockerCoreDataModel(name: "Eating", image: imageVM.currentImages[0].name, imageEntity: imageVM.currentImages[0], budget: 200000, period: .monthly, resetDate: DateComponents(day:1), spent: 10000)
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Button(action: {blockerVM.addBlockerEntity(blocker: newBlocker)}, label: {
                    Text("Add Blocker")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 100, height: 50, alignment: .center)
                        .background(Color.blue.opacity(0.8))
                        .padding()
                })
                
                ForEach(blockerVM.currentBlockers) { blocker in
                    Text("Name : \(blocker.name)")
                    
                    CustomAssetsImage(imageName: blocker.image.name, width: 100, height: 80, corner: 0)
                        .padding()
                    
                    Text("Budget : \(blocker.budget) Spent: \(blocker.spent) Earn: \(blocker.earned)")
                    Text("Currnt Budget: \(blocker.currentBudget)")
                    
                    Text("Period : \(blocker.period ?? "nil")")
                    
//                    if let reset = blocker.resetDate {
//                        Text("Reset Date : \(reset)")
//                    } else {
//                        Text("Reset Date : nil")
//                    }
                    
                    
                    
                    
                    
                }
                
                ForEach(imageVM.currentImages) { imageEntity in
                    CustomAssetsImage(imageName: imageEntity.name,
                                      width: 50,
                                      height: 30,
                                      corner: 0)
                        .padding()

                }
                
//                Button(action: {imageVM.deleteAllImage()}, label: {
//                    Text("Delete All")
//                        .foregroundColor(.white)
//                        .frame(width: 50, height: 50, alignment: .center)
//                        .background(Color.blue.opacity(0.8))
//                        .padding()
//                })
            }
        }
        
    }
}

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
            .environmentObject(ImageCoreDataViewModel())
            .environmentObject(BlockerCoreDataViewModel())
    }
}
