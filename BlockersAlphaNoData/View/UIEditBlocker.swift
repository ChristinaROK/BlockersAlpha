//
//  UIEditBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/11/04.
//

import SwiftUI

struct UIEditBlocker: View {
    
    var blocker : temptBlockerModel
    @State var name: String
    @State var budget: String
    @State var period: String
    @State var weekday: String
    @State var day: String
    @State var month: String
     
    init(blocker: temptBlockerModel) {
        self.blocker = blocker // [TODO] change into CoreDataBlocker
        _name = State(initialValue: self.blocker.name)
        _budget = State(initialValue: "\(self.blocker.budget)")
        _period = State(initialValue:  period2kor[self.blocker.period?.rawValue ?? "temp"]!) // 값이 한국어로 저장됨
        _weekday = State(initialValue: self.blocker.resetWeekday != 0 ? int2weekdays[self.blocker.resetWeekday]! : "월요일")
        _day = State(initialValue: self.blocker.resetDay != 0 ? "\(self.blocker.resetDay) 일" : "1 일")
        _month = State(initialValue: self.blocker.resetMonth != 0 ? "\(self.blocker.resetMonth) 월" : "1 월")
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                CustomAssetsImage(imageName: blocker.image, width: 200, height: 150, corner: 0)
                
                // [TODO] button
                
                Spacer()
                
                Form{
                    HStack{
                        CustomText(text: "이름", size: 20, weight: .bold, design: .default, color: .black)
                        
                        if #available(iOS 15.0, *) {
                            TextField("이름", text: $name, prompt: Text("새로운 예산 이름"))
                        } else {
                            // Fallback on earlier versions
                            TextField("새로운 예산 이름", text: $name)
                        }
                    }
                    
                    HStack{
                        CustomText(text: "예산 금액", size: 20, weight: .bold, design: .default, color: .black)
                        
                        if #available(iOS 15.0, *) {
                            TextField("금액", text: $budget, prompt: Text("새로운 예산 금액"))
                        } else {
                            // Fallback on earlier versions
                            TextField("새로운 예산 금액", text: $budget)
                        }
                    }
                    
                    HStack{
                        CustomText(text: "예산 주기", size: 20, weight: .bold, design: .default, color: .black)
                        
                        Picker("", selection: $period) {
                            ForEach(CustomPeriod.allCases) {
                                period in Text(period.rawValue).tag(period)
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                    }
                    
                    HStack{
                        CustomText(text: "예산 시작일", size: 20, weight: .bold, design: .default, color: .black)
                        
                        if period == "주간" {
                            Picker("", selection: $weekday) {
                                ForEach(CustomWeekdays.allCases) { day in
                                    Text("\(day.rawValue)").tag(day)
                                        .font(.system(size: 20, weight: .semibold, design: .default))
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                        } else if period == "월간" {
                            Picker("", selection: $day) {
                                ForEach(customDates, id: \.self) { date in
                                    Text(date).tag(date)
                                        .font(.system(size: 20, weight: .semibold, design: .default))
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                        } else if period == "연간" {
                            Picker("", selection: $month) {
                                ForEach(customMonth, id: \.self) { month in
                                    Text(month).tag(month)
                                        .font(.system(size: 20, weight: .semibold, design: .default))
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                            
                            Picker("", selection: $day) {
                                ForEach(customDates, id: \.self) { date in
                                    Text(date).tag(date)
                                        .font(.system(size: 20, weight: .semibold, design: .default))
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                        }
                    }

                }

            }
//            .toolbar(content: {
//                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
//                        CustomAssetsImage(imageName: "checkmark", width: 10, height: 10, corner: 0)
//                    }
//                }
//            )
//            .navigationTitle("예산 수정")
            // [TODO] navigation... 전부 사용 금지던데 무엇을 사용???
        }
    }
}

struct UIEditBlocker_Previews: PreviewProvider {
    static var previews: some View {
        UIEditBlocker(
            blocker: temptBlockerModel(name: "식비", image: "basic-blocker", budget: 10000, period: .weekly, resetWeekday: 2, resetDay: 0, resetMonth: 0, startDate: nil, endDate: nil)
        )
    }
}

struct temptBlockerModel: Identifiable {
    let id: UUID = UUID()
    var name: String
    var image: String
    var budget: Float
    var period: BlockerPeriodModel?
    var resetWeekday: Int
    var resetDay: Int
    var resetMonth: Int
    var startDate: Date?
    var endDate: Date?
}
