//
//  UIAddBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI

//TODO: 블로커 카드가 horizontal하게 움직이는 애니메이션 추가
struct UICreateImage: View {
    
    @EnvironmentObject var blockerModel: NewBlockerViewModel
    @EnvironmentObject var imageViewModel: ImageViewModel
    //    @State var blockerImage: String = "" {
    //        didSet {
    //            self.blockerModel.image = blockerImage
    //        }
    //    }
    
    var body: some View {
        
        VStack {
            CustomText(text: "예산을 지켜줄 블로커를 선택해 주세요", size: 22, weight: .semibold, design: .default, color: .black)
                .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.green)
                    .padding(.vertical)
                    .frame(width: 380, height: 380)
                    .opacity(0.6)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(imageViewModel.currentImages) { image in
                            Button(action: {
                                blockerModel.blocker.image = image.image
                            }, label: {
                                CustomAssetsImage(imageName: image.image, width: 210, height: 180, corner: 0)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .padding(.horizontal, 60)
                                    .shadow(radius: 15)
                            })
                        }
                    }
                    .offset(x: 35)
                })
            }
            
            if blockerModel.blocker.image != "" {
                
                Button(action: {}, label: {
                    /*
                     DEBUG
                     Text("\(blockerModel.blocker.image)")
                     */
                    NavigationButton(destination: AnyView(UICreateName()))
                })
                
                
            }
            
        }
        .offset(y: -20)
    }
    
}


struct UICreateName: View {
    
    @EnvironmentObject var blockerModel: NewBlockerViewModel
    @State var blockerName: String = "" // 왜 didset이 안먹을까?
    
    var body: some View {
        VStack {
            CustomText(text: "예산의 이름을 작성해주세요", size: 22, weight: .semibold, design: .default, color: .black)
                .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.green)
                    .padding(.vertical)
                    .frame(width: 380, height: 380)
                    .opacity(0.6)
                
                VStack {
                    if blockerModel.blocker.image == "" {
                        CustomSFImage(imageName: "exclamationmark.triangle.fill", renderMode: .template, width: 98, height: 90, corner: 0, color: .orange)
                            .padding()
                    } else {
                        CustomAssetsImage(imageName: blockerModel.blocker.image, width: 150, height: 120, corner: 20)
                            .padding()
                    }
                    
                    TextField("예산 이름", text: $blockerName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
            }
            
            if blockerName.count>0 {
                
                NavigationLink(
                    destination: UICreateBudget()) {
                    CustomSFImage(imageName: "arrow.forward.circle.fill", renderMode: .template, width: 80 , height: 80, corner: 0, color: Color.green)
                        .padding(.horizontal)
                }.simultaneousGesture(TapGesture().onEnded({
                    blockerModel.blocker.name = blockerName
                })
                )
                
            }
            
            
        }
        .offset(y: -20)
    }
}

// TODO: customized keyboard 개발 (원 단위 수 자동 생성)
struct UICreateBudget: View {
    
    @EnvironmentObject var blockerModel: NewBlockerViewModel
    @State var blockerAmount = ""
    
    
    var body: some View {
        
        VStack {
            /*
             DEBUG
             Text("\(blockerModel.blocker.image)")
             Text("\(blockerModel.blocker.name)")
             */
            CustomText(text: "관리할 예산 블럭의 총 금액을 알려주세요", size: 22, weight: .semibold, design: .default, color: .black)
                .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.green)
                    .padding(.vertical)
                    .frame(width: 380, height: 200)
                    .opacity(0.6)
                
                TextField("총 예산 금액", text: $blockerAmount)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            if let budget = Float(blockerAmount) {
                
                NavigationLink(
                    destination: UICreateType()) {
                    CustomSFImage(imageName: "arrow.forward.circle.fill", renderMode: .template, width: 80 , height: 80, corner: 0, color: Color.green)
                        .padding(.horizontal)
                }.simultaneousGesture(TapGesture().onEnded({
                    blockerModel.blocker.budget = budget
                })
                )
            }
            
        }
        .offset(y: -20)
    }
}


struct UICreateType: View {
    
    @EnvironmentObject var blockerModel: NewBlockerViewModel
    //@Binding var blockerModel: BlockerModel
    @State private var isClicked: Bool = false
    @State private var isOneTime: Bool = true
    
    var body: some View {
        VStack {
            
            VStack {
                
                /*
                 DEBUG
                 Text("\(blockerModel.blocker.name)")
                 Text("\(Int(blockerModel.blocker.budget))")
                 */
                
                CustomText(text: "관리할 예산 블럭의 성격을 알려주세요", size: 22, weight: .semibold, design: .default, color: .black)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.green)
                        .padding(.vertical)
                        .frame(width: 380, height: 200)
                        .opacity(0.6)
                    
                    HStack(spacing: 40) {
                        Button {
                            isOneTime.toggle()
                            if isClicked {
                                isClicked.toggle()
                            }
                        } label: {
                            CircleText(text: "반복")
                        }
                        
                        Button {
                            if isOneTime == false {
                                isOneTime.toggle()
                            }
                            
                            if isClicked == false {
                                isClicked.toggle()
                            }
                            
                            if blockerModel.blocker.period != nil {
                                blockerModel.blocker.period = nil
                            }
                        } label: {
                            CircleText(text: "일회성")
                        }
                    }
                }
            }
            
            VStack {
                CustomText(text: "관리할 예산 블럭의 주기를 알려주세요", size: 22, weight: .semibold, design: .default, color: .black)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.green)
                        .padding(.vertical)
                        .frame(width: 380, height: 200)
                        .opacity(0.6)
                    
                    HStack(spacing: 5) {
                        Button(action: {
                            blockerModel.blocker.period = .weekly
                            if isClicked == false {
                                isClicked.toggle()
                            }
                        }, label: {
                            CircleText(text: "주간")
                        })
                        
                        Button(action: {
                            blockerModel.blocker.period = .monthly
                            if isClicked == false {
                                isClicked.toggle()
                            }
                        }, label: {
                            CircleText(text: "월간")
                        })
                        
                        Button(action: {
                            blockerModel.blocker.period = .yearly
                            if isClicked == false {
                                isClicked.toggle()
                            }
                        }, label: {
                            CircleText(text: "연간")
                        })
                    }
                }
            }
            .isEmpty(isOneTime) // custom view modifier
            
            if isClicked {
                NavigationButton(destination: AnyView(UICreateDate()))
            }
            
        }
        .offset(y: -20)
    }
}


struct UICreateDate: View {
    
    @EnvironmentObject var blockerModel: NewBlockerViewModel
    @State var selectedWeekday = CustomWeekdays.일요일
    @State var selectedDate = "1 일"
    @State var selectedMonth = "1 월"
    @State private var _month : Int? = 1
    
    @State var selectedStartDate = Date()
    
    var body: some View {
        
        VStack {
            CustomText(text: "예산 블럭의 시작일을 알려주세요", size: 20, weight: .semibold, design: .default, color: .black)
            
            if let period = blockerModel.blocker.period {
                
                CustomText(text: "(모든 예산은 시작일이 되면 초기화 됩니다.)", size: 18, weight: .semibold, design: .default, color: .black)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.green)
                        .padding(.vertical)
                        .frame(width: 380, height: 380)
                        .opacity(0.6)
                    
                    switch period {
                    case .weekly:
                        Picker("", selection: $selectedWeekday) {
                            ForEach(CustomWeekdays.allCases) { day in
                                Text("\(day.rawValue)").tag(day).font(.system(size: 22, weight: .semibold, design: .default))
                            }
                        }
                        .onAppear(perform: {
                            blockerModel.blocker.resetDate = DateComponents(weekday: weekdays2int[selectedWeekday.rawValue])
                        })
                        .onChange(of: selectedWeekday, perform: { value in
                            blockerModel.blocker.resetDate = DateComponents(weekday: weekdays2int[value.rawValue])
                        })
                        .labelsHidden()
                        .padding()

                    case .monthly:
                        VStack(spacing: 5) {

                            Picker("", selection: $selectedDate) {
                                ForEach(customDates, id: \.self) { date in
                                    Text(date).tag(date).font(.system(size: 22, weight: .medium, design: .default))
                                }
                            }
                            .onAppear(perform: {
                                blockerModel.blocker.resetDate = DateComponents(day: days2int[selectedDate])
                            })
                            .onChange(of: selectedDate, perform: { value in
                               blockerModel.blocker.resetDate = DateComponents(day:
                                    days2int[value])
                            })

                            .labelsHidden()
                            .padding()

                            CustomText(text: "⚠️ 일수가 모자란 달은 자동으로 계산됩니다.", size: 18, weight: .semibold, design: .default, color: .black)
                        }
                    case .yearly:
                        HStack(spacing: 0) {

                            VStack(spacing:0) {
                                Text("월")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                    .padding()
                                    .frame(width: 100, height: 35, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(10)


                                Picker("", selection: $selectedMonth) {
                                    ForEach(customMonth, id: \.self) { month in
                                        Text(month).tag(month).font(.system(size: 22, weight: .medium, design: .default))
                                    }
                                }
                                .onChange(of: selectedMonth, perform : {
                                    value in _month = month2int[value]
                                })
                                .labelsHidden()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.5)
                            .clipped()

                            VStack(spacing:0) {
                                Text("일")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                    .padding()
                                    .frame(width: 100, height: 35, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(10)


                                Picker("", selection: $selectedDate) {
                                    ForEach(customDates, id: \.self) { date in
                                        Text(date).tag(date).font(.system(size: 22, weight: .semibold, design: .default))
                                    }
                                }
                                .onAppear(perform: {
                                    blockerModel.blocker.resetDate = DateComponents(month: _month, day: days2int[selectedDate])
                                })
                                .onChange(of: selectedDate, perform : {
                                    value in
                                        if let _month = _month {
                                            blockerModel.blocker.resetDate = DateComponents(month: _month, day: days2int[value])
                                        }
                                })
                                .labelsHidden()
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.5)
                            .clipped()


                        }
                    
                    }
                }
                
                NavigationButton(destination: AnyView(UICreateSpent()))
                
            } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.green)
                            .padding(.vertical)
                            .frame(width: 380, height: 380)
                            .opacity(0.5)
    
                        // TODO: locale 적용
                        DatePicker("", selection: $selectedStartDate, displayedComponents: [.date])
                            .onAppear(perform: {
                                blockerModel.blocker.startDate = selectedStartDate
                            })
                            .onChange(of: selectedStartDate, perform : {
                                value in blockerModel.blocker.startDate = value
                            })
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
    
                    NavigationButton(destination: AnyView(UICreateEndDate()))
                        .offset(y:60)
                
            }
            
            /* DEBUG
             Text("DEBUG \(blockerModel.blocker.name)")
             Text("DEBUG\(blockerModel.blocker.budget)")

             if let period = blockerModel.blocker.period?.rawValue {
                 Text("DEBUG \(period)")
             }

             if let resetDate =  blockerModel.blocker.resetDate {
                 Text("DEBUG \(resetDate)")
             }

             if let startDate = blockerModel.blocker.startDate {
                 Text("DEBUG \(startDate)")
             }
             */
        }
        .offset(y: -20)
    }
}

struct UICreateSpent: View {
    
    @EnvironmentObject var blockerModel: NewBlockerViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var blockerViewModel: BlockerViewModel
    @State var spent = ""
    
    var body: some View {
        
        VStack {
            
            CustomText(text: "예산 중 이미 사용한 금액이 있다면, 블로커에게 알려주세요", size: 20, weight: .semibold, design: .default, color: .black)
                .padding()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.green)
                    .padding(.vertical)
                    .frame(width: 380, height: 200)
                    .opacity(0.6)
                
                
                TextField("이미 사용한 금액", text: $spent)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            
            if let spent = Float(spent) {
                
                Button(action: {
                    blockerModel.blocker.spent = spent
                    blockerViewModel.currentBlockers.append(blockerModel.blocker)
                    // Initialize ViewModel
                    blockerModel.blocker = BlockerModel(name: "", image: "", budget: 0, histories: [])
                    DispatchQueue.main.async {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    CustomText(text: "예산 생성", size: 25, weight: .bold, design: .default, color: .white)
                        .frame(width: 120, height: 30, alignment: .center)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                })
            }
        }
        .offset(y: -20)
        
    }
}


struct UICreateEndDate: View {
    @EnvironmentObject var blockerModel: NewBlockerViewModel
    @EnvironmentObject var blockerViewModel: BlockerViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var selectedEndDate: Date = Date()
    
    // Computed Property
    var startDate: Date { blockerModel.blocker.startDate ?? Date() > Date() ? blockerModel.blocker.startDate! : Date() } // max(today, startDate)
    var dateRange: PartialRangeFrom<Date> {
        let current = Calendar.current
        let startCompenet = current.dateComponents([.year, .month, .day], from: startDate)
        return current.date(from: startCompenet)!...
    }
    
    var body: some View {
        VStack {
            
            CustomText(text: "예산 블럭의 종료일을 알려주세요", size: 20, weight: .semibold, design: .default, color: .black)
                .padding()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.green)
                    .padding(.vertical)
                    .frame(width: 380, height: 360)
                    .opacity(0.6)
                
                // TODO: locale 적용
                DatePicker("", selection: $selectedEndDate, in: dateRange,  displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .onAppear(perform: {
                        blockerModel.blocker.endDate = selectedEndDate
                    })
                    .onChange(of: selectedEndDate, perform: { value in
                        blockerModel.blocker.endDate = value
                    })
            }
            
            Button(action: {
                blockerViewModel.currentBlockers.append(blockerModel.blocker)
                // Initialize ViewModel
                blockerModel.blocker = BlockerModel(name: "", image: "", budget: 0, histories: [])
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()}
            }, label: {
                CustomText(text: "예산 생성", size: 25, weight: .bold, design: .default, color: .white)
                    .frame(width: 120, height: 30, alignment: .center)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            })
        }
        .offset(y: -20)
    }
}


struct CircleText: View {
    
    @State var text: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 80, height: 80, alignment: .center)
            CustomText(text: text, size: 22, weight: .semibold, design: .default, color: .orange)
        }
        .padding()
    }
}

struct NavigationButton: View {
    
    @State var destination: AnyView
    
    var body: some View {
        NavigationLink(
            destination: destination,
            label: {
                CustomSFImage(imageName: "arrow.forward.circle.fill", renderMode: .template, width: 80 , height: 80, corner: 0, color: Color.green)
                    .padding(.horizontal)
            })
    }
}

struct EmptyModifier: ViewModifier {
    let isEmpty: Bool
    
    func body(content: Content) -> some View {
        Group {
            if isEmpty {
                EmptyView()
            } else {
                content
            }
        }
    }
}

extension View {
    func isEmpty(_ bool: Bool) -> some View {
        modifier(EmptyModifier(isEmpty: bool))
    }
}

struct UIAddBlocker_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            
            //UICreateImage()
            
            //UICreateName()
            
            //UICreateBudget()
            
            //UICreateType()
            
            UICreateDate()
            
            //UICreateSpent()
            
            //UICreateEndDate()
            
        }
        .environmentObject(ImageViewModel())
        .environmentObject(BlockerViewModel())
        .environmentObject(NewBlockerViewModel())
        
    }
}
