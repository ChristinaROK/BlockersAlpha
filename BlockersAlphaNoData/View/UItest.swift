//
//  UItest.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/07/18.
//

import SwiftUI

struct UItest: View {
    
    @EnvironmentObject var blockerViewModel : BlockerViewModel
    
    @EnvironmentObject var imageViewModel : ImageViewModel
    
    var body: some View {
        List {
            ForEach(blockerViewModel.currentBlockers) { blocker in
                VStack {
                    Text("Name: \(blocker.name)")
                    Image(blocker.image)
                    Text("Budget: \(blocker.budget.currencyRepresentation)")
                    Text("Period: \(blocker.period ?? "")")
                    Text("ResetDate: \(blocker.resetDate ?? "")")
                    Text("Spent: \(blocker.spent?.currencyRepresentation ?? "")")
                    Text("current Amount: \(blocker.getCurrentBudget().currencyRepresentation)")
                    
                    if let startDate = blocker.startDate {
                        HStack {
                            Text("Start Date:")
                            Text(startDate, style: .date)
                        }
                    }
                    
                    if let endDate = blocker.endDate {
                        HStack {
                            Text("End Date:")
                            Text(endDate, style: .date)
                        }
                    }
                    
                    if blocker.histories.isEmpty {
                        Text("history is empty")
                    } else {
                        ForEach(blocker.histories, id: \.self) { history in
                            Text(history.memo)
                        }
                    }
                }
            }
        }
        .navigationTitle("View Model Test")
    }
}

struct UItest_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UItest()
        }
        .environmentObject(BlockerViewModel())
        .environmentObject(ImageViewModel())
        
    }
}
