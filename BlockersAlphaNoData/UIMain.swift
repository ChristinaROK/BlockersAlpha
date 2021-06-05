//
//  ContentView.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIMain: View {
    
    @State private var istoday = false
    var blockers: [Blocker] = BlockerList.mainBlockerList
    
    var body: some View {
        VStack {
            HStack(spacing: 200) {
                HStack{
                    CustomText(text: "Today",
                               size: 20,
                               weight: .bold,
                               design: .serif,
                               color: .black)
                    
                    Toggle("today", isOn: $istoday)
                        .labelsHidden()
                }
                
                
                CustomSFImage(imageName: "person.fill",
                              width: 40,
                              height: 50,
                              corner: 0)
            }
            
            NavigationView{
                VStack{
                    // TODO: List와 NavigationLink 사이의 공간을 없애고 동일한 ui로 만들기
                    List(blockers, id: \.id) { blocker in
                        NavigationLink(
                            destination: UIDetail(blocker: blocker),
                            label: {
                                BlockerIndividual(blocker: blocker)
                            }
                        )
                    }
                    
                    NavigationLink(
                        destination: UIAddBlocker(),
                        label: {
                            CustomSFImage(imageName: "person.fill.badge.plus",
                                          width: 80,
                                          height: 80,
                                          corner: 0)
                        }
                    )
                }
            }
            
            HStack(spacing:20) {
                // TODO: NavigationLink를 중간으로, Image를 가장 오른쪽으로 정렬
                
                NavigationLink(
                    destination: UIDeposit(),
                    label: {
                        CustomSFImage(imageName: "dollarsign.square.fill",
                                      width: 50,
                                      height: 50,
                                      corner: 0)
                    }
                )
                
                CustomSFImage(imageName: "gearshape.fill",
                              width: 30,
                              height: 30,
                              corner: 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UIMain()
    }
}

struct BlockerIndividual: View {
    
    var blocker : Blocker
    
    var body: some View {
        HStack (spacing: 30) {
            CustomAssetsImage(imageName: blocker.image,
                              width: 100,
                              height: 80,
                              corner: 50)
            
            VStack {
                CustomText(text: blocker.name,
                           size: 30,
                           weight: .semibold,
                           design: .serif,
                           color: .blue)
                CustomText(text: "\(blocker.balance)",
                           size: 20,
                           weight: .semibold,
                           design: .serif,
                           color: .black)
            }
            
            CustomText(text: blocker.dDay,
                       size: 30,
                       weight: .semibold,
                       design: .serif,
                       color: .black)
        }
    }
}
