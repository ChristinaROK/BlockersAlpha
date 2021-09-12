//
//  UItest.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/07/18.
//

import SwiftUI

struct UItest: View {
    
    @EnvironmentObject var blockerViewModel : BlockerCoreDataViewModel
    
    @EnvironmentObject var imageViewModel : ImageCoreDataViewModel
    
    var body: some View {
        
//        VStack {
        List {
            ForEach(blockerViewModel.currentBlockers) { blocker in
                VStack {
                    Text("Name: \(blocker.name)")
                 
                    Text("Budget: \(blocker.budget.currencyRepresentation)")
                    Text("Period: \(blocker.period ?? "")")
//                    Text("ResetDate: \(Calendar.current.date(from: blocker.resetDate ?? DateComponents(day:1)) ?? Date())")
                    Text("Spent: \(blocker.spent.currencyRepresentation)")
                    Text("current Amount: \(blocker.currentBudget.currencyRepresentation)")
//
//                    if let startDate = blocker.startDate {
//                        HStack {
//                            Text("Start Date:")
//                            Text(startDate, style: .date)
//                        }
//                    }
//
//                    if let endDate = blocker.endDate {
//                        HStack {
//                            Text("End Date:")
//                            Text(endDate, style: .date)
//                        }
//                    }
//
//                    if blocker.histories.isEmpty {
//                        Text("history is empty")
//                    } else {
//                        ForEach(blocker.histories, id: \.self) { history in
//                            Text(history.memo)
//                        }
//                    }
                    
                    //Text("\(Calendar.current.startOfDay(for: Date()))")
                    //Text("closestNextDate: \(blocker.nextDate.description)")
                    Text("dDay: \(blocker.dDay)")
                    Text("today: \(Date())")
                    Text("dTime: \(blocker.dTime)")
                    Text("today budget: \(blocker.todayBudget.currencyRepresentation)")
                }
            }
        }
        .navigationTitle("View Model Test")
        
        
//        }
        
    }
}


struct Tempt: View {
    @State var wakeUp = Date()
    
    var body: some View {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        
        dateFormatter.dateFormat = " yyyy / MM / dd / EEEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let dateString = dateFormatter.string(from: wakeUp)
        
        return Text("\(dateString)")
        
    }
}


struct UItest_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UItest()
        }
        .environmentObject(BlockerCoreDataViewModel())
        .environmentObject(ImageCoreDataViewModel())
//        Tempt()
    }
}
