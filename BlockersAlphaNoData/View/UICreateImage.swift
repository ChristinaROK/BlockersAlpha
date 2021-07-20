//
//  UIAddBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI

//TODO: 블로커 카드가 horizontal하게 움직이는 애니메이션 추가

struct UICreateImage: View {
    
    @EnvironmentObject var imageViewModel: ImageViewModel
    @State var blockerImage: String = ""
    
    var body: some View {
        
        VStack {
            CustomText(text: "예산을 지켜줄 블로커를 선택해 주세요", size: 22, weight: .semibold, design: .default, color: .black)
                .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.green)
                    .padding(.vertical)
                    .frame(width: 450, height: 380)
                    .opacity(0.6)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(imageViewModel.currentImages) { image in
                            Button(action: {
                                blockerImage = image.image
                            }, label: {
                                CustomAssetsImage(imageName: image.image, width: 210, height: 180, corner: 0)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .padding(.horizontal, 60)
                                    .shadow(radius: 15)
                            })
                        }
                    }
                    .offset(x: 56)
                })
            }
            
            if blockerImage != "" {
                NavigationButton(destination: AnyView(UICreateName(blockerImage: $blockerImage)))
            }
            
        }
        .offset(y: -20)
    }
    
}

// TODO: TextField의 onEditingChanged, onCommit 파라미터에 클로저 추가해 데이터를 저장할 것

struct UICreateName: View {
    
    @Binding var blockerImage: String
    @State var blockerName = ""
    
    var body: some View {
        VStack (spacing:60) {
            CustomText(text: "예산의 이름을 작성해주세요", size: 22, weight: .semibold, design: .default, color: .black)
                .padding()
            
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.frame(height: 150)
                    .opacity(0.6)
                
                VStack {
                    
                    if blockerImage == "" {
                        CustomSFImage(imageName: "exclamationmark.triangle.fill", renderMode: .template, width: 98, height: 90, corner: 0, color: .orange)
                            .padding()
                    } else {
                        CustomAssetsImage(imageName: blockerImage, width: 150, height: 120, corner: 20)
                            .padding()
                    }

                    HStack{
                        CustomText(text: "NAME", size: 20, weight: .bold, design: .default, color: Color.black)
                        TextField("예산 이름", text: $blockerName)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    .padding(.horizontal)
                }
               
            }
  
            NavigationButton(destination: AnyView(UICreateBudget(blockerImage: $blockerImage, blockerName: $blockerName)))

        }
        .offset(y: -20)
    }
}

// TODO: 1. customized keyboard 개발 (원 단위 수 자동 생성)

struct UICreateBudget: View {
    
    @Binding var blockerImage: String
    @Binding var blockerName: String
    @State var blockerAmount = ""
    
    
    var body: some View {
        
        VStack(spacing: 60) {
            CustomText(text: "관리할 예산 블럭의 총 금액을 알려주세요.", size: 22, weight: .semibold, design: .default, color: .black)
            
            ZStack {
                
                Rectangle()
                    .fill(Color.green)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                    .frame(height:120)
                    .opacity(0.6)
                
            HStack{
                CustomText(text: "BUDGET", size: 20, weight: .bold, design: .default, color: Color.black)
                TextField("총 예산 금액", text: $blockerAmount)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            }
            
            // create Blocker model
            let newblocker = BlockerModel(name: blockerName, image: blockerImage, budget: Float(blockerAmount) ?? 0, period: nil, resetDate: nil, spent: nil, startDate: nil, endDate: nil, histories: [])
            
            NavigationButton(destination: AnyView(UICreateType(blockerModel: newblocker)))
            
        }
        .offset(y: -20)
    }
}


struct UICreateType: View {
    
    @State var blockerModel: BlockerModel
    @State var isOneTime: Bool = true
    @State var period: String?
    
    var body: some View {
        VStack {
            
            /* debug */
            Text(blockerModel.name)
            Text(blockerModel.period ?? "empty")
            
            VStack {
                CustomText(text: "관리할 예산 블럭의 성격을 알려주세요", size: 22, weight: .semibold, design: .default, color: .black)
                
                HStack(spacing: 40) {
                    Button {
                        isOneTime.toggle()
                    } label: {
                        CircleText(text: "주간")
                    }
                    
                    Button {
                        if isOneTime == false {
                            isOneTime.toggle()
                        }
                        
                        if blockerModel.period != nil {
                            blockerModel.period = nil
                        }
                    } label: {
                        CircleText(text: "일회성")
                    }
                }
            }

            VStack {
                CustomText(text: "관리할 예산 블럭의 주기를 알려주세요", size: 22, weight: .semibold, design: .default, color: .black)
                
                HStack(spacing: 5) {
                    Button(action: {
                        period = "Weekly"
                        blockerModel.period = period
                    }, label: {
                        CircleText(text: "주간")
                    })
                    
                    Button(action: {
                        period = "Monthly"
                        blockerModel.period = period
                    }, label: {
                        CircleText(text: "월간")
                    })
                    
                    Button(action: {
                        period = "Yearly"
                        blockerModel.period = period
                    }, label: {
                        CircleText(text: "연간")
                    })
                }
            }
            .isEmpty(isOneTime) // custom view modifier
            
            NavigationButton(destination: AnyView(UICreateDate(isOneTime: isOneTime, blockerModel: $blockerModel)))
                .offset(y:80)
            
        }
        .offset(y: -20)
    }
}

// START FROM HERE
struct UICreateDate: View {
    
    let isOneTime: Bool
    @Binding var blockerModel: BlockerModel
    @State var date: Date = Date()
    @State var selectedDay = CustomDays.월요일
    
    enum CustomDays: String, CaseIterable, Identifiable {
        case 월요일
        case 화요일
        case 수요일
        case 목요일
        case 금요일
        case 토요일
        case 일요일
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        
        if isOneTime {
            // 일회성 모드
        } else {
            // 반복 모드
            VStack{
                CustomText(text: "예산 블럭의 시작일을 알려주세요", size: 20, weight: .semibold, design: .default, color: .black)
                CustomText(text: "(모든 예산은 시작일이 되면 초기화 됩니다.)", size: 18, weight: .semibold, design: .default, color: .black)
            
            
            if blockerModel.period == "Weekly" {
                // 주별 View
                Picker("", selection: $selectedDay) {
                    ForEach(CustomDays.allCases) { day in
                        Text(day.rawValue).tag(day)
                    }
                }
                .labelsHidden()
                .padding()
                
                /* debug */
                Text("\(selectedDay.rawValue)")
                
            } else if blockerModel.period == "Monthly" {
                // 월별 View
            } else {
                // 연별 View
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()
            }
                
            }
        }
    }
}


struct CircleText: View {
    
    @State var text: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green)
                .frame(width: 80, height: 80, alignment: .center)
                .opacity(0.6)
            CustomText(text: text, size: 22, weight: .semibold, design: .default, color: .white)
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
            UICreateDate(isOneTime: false, blockerModel: .constant(BlockerModel(name: "식비", image: "eat-blocker", budget: 600000, period: "Weekly", resetDate: nil, spent: nil, startDate: nil, endDate: nil, histories: [])))
        }
        .environmentObject(ImageViewModel())
        
    }
}
