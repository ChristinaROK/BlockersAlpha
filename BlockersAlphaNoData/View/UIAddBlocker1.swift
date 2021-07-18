//
//  UIAddBlocker.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/05.
//

import SwiftUI

//TODO: 블로커 카드가 horizontal하게 움직이는 애니메이션 추가

struct UIAddBlocker1: View {
    
    @EnvironmentObject var imageViewModel: ImageViewModel
    
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
                            CustomAssetsImage(imageName: image.image, width: 210, height: 180, corner: 0)
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

// TODO: TextField의 onEditingChanged, onCommit 파라미터에 클로저 추가해 데이터를 저장할 것

struct UIAddBlocker2: View {
    
    @State private var blockerName = ""
    
    var body: some View {
        VStack (spacing:60) {
            CustomText(text: "예산의 이름을 작성해주세요", size: 22, weight: .semibold, design: .default, color: .black)
                .padding()
            
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(0.6)
            HStack{
                CustomText(text: "NAME", size: 20, weight: .bold, design: .default, color: Color.black)
                TextField("예산 이름", text: $blockerName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
            .padding(.horizontal)
            }
  
            NavigationButton(destination: AnyView(UIAddBlocker3()))

        }
        .offset(y: -20)
    }
}

// TODO: 1. customized keyboard 개발 (원 단위 수 자동 생성) 2. string 입력 값을 float로 변환해 데이터에 저장

struct UIAddBlocker3: View {
    
    @State private var blockerAmount = ""
    
    var body: some View {
        
        VStack(spacing: 60) {
            CustomText(text: "관리할 예산 블럭의 총 금액을 알려주세요.", size: 22, weight: .semibold, design: .default, color: .black)
            
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(0.6)
            HStack{
                CustomText(text: "BUDGET", size: 20, weight: .bold, design: .default, color: Color.black)
                TextField("총 예산 금액", text: $blockerAmount)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            }
  
            NavigationButton(destination: AnyView(UIAddBlocker4()))
            
        }
        .offset(y: -20)
    }
}


struct UIAddBlocker4: View {
    
    @State private var isOneTime: Bool = true
    
    var body: some View {
        VStack {
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
                    // TODO: save and pass to next view
                    } label: {
                        CircleText(text: "일회성")
                    }
                }
            }

            VStack {
                CustomText(text: "관리할 예산 블럭의 주기를 알려주세요", size: 22, weight: .semibold, design: .default, color: .black)
                
                HStack(spacing: 5) {
                    CircleText(text: "주간")
                    CircleText(text: "월간")
                    CircleText(text: "연간")
                }
            }
            .isEmpty(isOneTime) // custom view modifier
            
            NavigationButton(destination: AnyView(UIAddBlocker5()))
                .offset(y:80)
            
        }
        .offset(y: -20)
    }
}

// START FROM HERE
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
            UIAddBlocker1()
        }
        .environmentObject(ImageViewModel())
        
    }
}
