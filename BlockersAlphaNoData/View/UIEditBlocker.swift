//
//  UIEditBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/11/04.
//

import SwiftUI

struct UIEditBlocker: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var blockerViewModel : BlockerCoreDataViewModel
    var blocker : BlockerEntity
    @State var name: String
    @State var budget: String
    @State var period: String
    @State var weekday: String
    @State var day: String
    @State var month: String
     
    init(blocker: BlockerEntity) {
        self.blocker = blocker
        _name = State(initialValue: self.blocker.name)
        _budget = State(initialValue: "\(self.blocker.budget)")
        _period = State(initialValue:  period2kor[self.blocker.period ?? "temp"]!) // 값이 한국어로 저장됨
        _weekday = State(initialValue: self.blocker.resetWeekday != 0 ? int2weekdays[Int(self.blocker.resetWeekday)]! : "월요일")
        _day = State(initialValue: self.blocker.resetDay != 0 ? "\(self.blocker.resetDay) 일" : "1 일")
        _month = State(initialValue: self.blocker.resetMonth != 0 ? "\(self.blocker.resetMonth) 월" : "1 월")
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                CustomAssetsImage(imageName: blocker.image.name, width: 200, height: 150, corner: 0)
                
                // [TODO] button
                Text("(블로커 변경하기 버튼)")
                
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
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    if period == "연간" {
                        HStack {
                            CustomText(text: "예산 시작일 (월)", size: 20, weight: .bold, design: .default, color: .black)
                            
                            Picker("", selection: $month) {
                                ForEach(customMonth, id: \.self) { month in
                                    Text(month).tag(month)
                                        .font(.system(size: 20, weight: .semibold, design: .default))
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                        }
                        
                        HStack {
                            CustomText(text: "예산 시작일 (일)", size: 20, weight: .bold, design: .default, color: .black)
                            
                            Picker("", selection: $day) {
                                ForEach(customDates, id: \.self) { date in
                                    Text(date).tag(date)
                                        .font(.system(size: 20, weight: .semibold, design: .default))
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                        }
                    } else {
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
                            }
                        }
                    }
                }
                .navigationTitle("예산 수정")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            CustomSFImage(imageName: "arrow.backward", renderMode: .template, width: 20, height: 20, corner: 0, color: .black)
                        }

                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            blockerViewModel.updateBlockerEntity(blocker: blocker, name: name)
                        } label: {
                            CustomSFImage(imageName: "checkmark.circle.fill", renderMode: .template, width: 20, height: 20, corner: 0, color: .green)
                        }

                    }
                }
            }
                
        }
    }
}

//struct UIEditBlocker_Previews: PreviewProvider {
//    static var previews: some View {
//        UIEditBlocker(
//            blocker: temptBlockerModel(name: "식비", image: "basic-blocker", budget: 10000, period: .weekly, resetWeekday: 2, resetDay: 0, resetMonth: 0, startDate: nil, endDate: nil)
//        )
//    }
//}

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
