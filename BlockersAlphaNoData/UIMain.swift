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
        NavigationView {
            VStack {
                VStack{
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
                    
                    // TODO : change to floating button
                    NavigationLink(
                        destination: UIDeposit(),
                        label: {
                            CustomSFImage(imageName: "dollarsign.square.fill",
                                          width: 90,
                                          height: 50,
                                          corner: 5)
                        }
                    )
                }
                .offset(x: 0, y: -60)
                
                HStack {
                    CustomSFImage(imageName: "gearshape.fill",
                                  width: 30,
                                  height: 30,
                                  corner: 0)
                        .padding(.leading, 300)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
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
                }
            }
        }
        .accentColor(Color(.label))
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
