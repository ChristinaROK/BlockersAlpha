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
                    //TODO: List와 NavigationLink 사이의 공간을 없애고 동일한 ui로 만들기위해서는 아래 navigationlink가 위의 list로 들어와야 함
                    Form {
                        Section {
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
                                                  width: 50,
                                                  height: 50,
                                                  corner: 0)
                                        .padding(.leading, 120)
                                }
                            )
                        }
                    }
                    
                    NavigationLink(
                        destination: UIDeposit(),
                        label: {
                            CustomSFImage(imageName: "dollarsign.square.fill",
                                          width: 90,
                                          height: 70,
                                          corner: 5)
                        }
                    )
                }
            }
            
            HStack {
                CustomSFImage(imageName: "gearshape.fill",
                              width: 30,
                              height: 30,
                              corner: 0)
                    .padding(.leading, 300)
            }
        }
    }
}

struct UIMain_Previews: PreviewProvider {
    static var previews: some View {
        UIMain()
    }
}

struct BlockerIndividual: View {
    
    var blocker : Blocker
    
    var body: some View {
        HStack (spacing: 20) {
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
