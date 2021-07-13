//
//  UIAddBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI


struct UIAddBlocker1: View {
    
    var body: some View {
        
            VStack {
                CustomText(text: "예산을 지켜줄 블로커를 선택해 주세요", size: 20, weight: .semibold, design: .default, color: .black)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 350, height: 400, alignment: .center)
                        .opacity(0.6)
                    
                    VStack {
                        
                        HStack {
                            CustomAssetsImage(imageName: "eat-blocker", width: 110, height: 80, corner: 150)
                                .shadow(radius: 10)
                            
//                            CustomSFImage(imageName: "person.fill.questionmark", width: 30, height: 30, corner: 0)
//                                .padding(.all, 70)
                            
                            CustomSFImage(imageName: "person.fill.questionmark", width: 30, height: 30, corner: 0)
                                .padding(.all, 70)
                        }
                        
                        HStack {
                            CustomSFImage(imageName: "person.fill.questionmark", width: 30, height: 30, corner: 0)
                                .padding(.all, 70)
                            
                            CustomSFImage(imageName: "person.fill.questionmark", width: 30, height: 30, corner: 0)
                                .padding(.all, 70)
                        }
                    }
                }
                
                NavigationLink(
                    destination: UIAddBlocker2(),
                    label: {
                        CustomText(text: "블로커 선택하기", size: 15, weight: .semibold, design: .default, color: .white)
                            .padding(.all, 10)
                            .background(Color.green.opacity(0.8))
                    })
            }
            .offset(y: -20)
        }
    
}

struct UIAddBlocker2: View {
    
    @State private var name = ""
    
    var body: some View {
        VStack {
            CustomText(text: "예산 블럭의 이름을 작성해주세요.", size: 20, weight: .semibold, design: .default, color: .black)
            
            ZStack {
                // # TODO: replace text to shape with specified size
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green)
                    .frame(width: 350, height: 50, alignment: .center)
                    .opacity(0.6)
                
                TextField("Blocker Name: ", text: $name)
                    .offset(x: 50, y: 0)
            }
            
            NavigationLink(
                destination: UIAddBlocker3(),
                label: {
                    CustomText(text: "다음", size: 15, weight: .semibold, design: .default, color: .white)
                        .padding(.all, 10)
                        .background(Color.green.opacity(0.8))
                })

            
        }
    }
}

struct UIAddBlocker3: View {
    
    @State private var amount = "0 ￦"
    
    // TODO: 1. ui navigation bar 모든 뷰에 생성 (pre, next button) / 2. customized keyboard 개발
    var body: some View {
        
        VStack {
            CustomText(text: "관리할 예산 블럭의 총 금액을 알려주세요.", size: 20, weight: .semibold, design: .default, color: .black)
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green)
                    .frame(width: 350, height: 50, alignment: .center)
                    .opacity(0.6)
                
                HStack {
                    TextField("Amount", text: $amount)
                        .offset(x: 40, y: 2)
                    
                    Button {
                        // numeric keypad
                    } label: {
                        CustomSFImage(imageName: "keyboard.chevron.compact.down", width: 20, height: 20, corner: 0.2)
                    }
                    .offset(x: -40, y: 2)
                }
            }
        }
    }
}

struct UIAddBlocker4: View {

    var body: some View {
        VStack {
            VStack {
                CustomText(text: "관리할 예산 블럭의 주기를 알려주세요.", size: 20, weight: .semibold, design: .default, color: .black)
                 // todo : button으로 바꾸기 (데이터 입력)
                HStack(spacing: 20) {
                    CircleText(text: "주간")
                    CircleText(text: "월간")
                    CircleText(text: "연간")
                    CircleText(text: "일회성")
                }
            }
            
        }
    }
}

struct UIAddBlocker5: View {
    var body: some View {
        VStack {
            VStack {
                CustomText(text: "예산 블럭의 시작일을 알려주세요", size: 20, weight: .semibold, design: .default, color: .black)
                CustomText(text: "(모든 예산은 시작일이 되면 초기화 됩니다.)", size: 18, weight: .semibold, design: .default, color: .black)
                
                // TODO: 이전 View의 값을 받아서 그 값에 따라 view 변경
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
                .frame(width: 55, height: 55, alignment: .center)
                .opacity(0.6)
            CustomText(text: text, size: 20, weight: .semibold, design: .default, color: .white)
        }

    }
}

struct UIAddBlocker_Previews: PreviewProvider {
    static var previews: some View {
        UIAddBlocker1()
    }
}
