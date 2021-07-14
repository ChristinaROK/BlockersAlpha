//
//  UIAddBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI

//TODO: 블로커 카드가 horizontal하게 움직이는 애니메이션 추가

struct UIAddBlocker1: View {
    
    @State var blockers: [Blocker] = BlockerList.mainBlockerList
    
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
                        ForEach(blockers) { blocker in
                            CustomAssetsImage(imageName: blocker.image, width: 210, height: 180, corner: 0)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .padding(.horizontal, 60)
                                .shadow(radius: 15)
                        }
                    }
                    .offset(x: 56)
                })
            }
            
            NavigationButton(destination: AnyView(UIAddBlocker2()))
        }
        .offset(y: -20)
    }
    
}

struct UIAddBlocker2: View {
    
    @State private var blockerName = ""
    
    var body: some View {
        VStack (spacing:100) {
            CustomText(text: "예산의 이름을 작성해주세요", size: 22, weight: .semibold, design: .default, color: .black)
                .padding()
            
            HStack{
                CustomText(text: "NAME", size: 20, weight: .light, design: .default, color: Color.black)
                TextField("예산 이름", text: $blockerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            .padding(.horizontal)
            
                
                
            NavigationButton(destination: AnyView(UIAddBlocker3()))

        }
        .offset(y: -20)
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


struct UIAddBlocker_Previews: PreviewProvider {
    static var previews: some View {
        UIAddBlocker2()
    }
}
