//
//  ContentView.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIMain: View {
    
    @State private var istoday = false
    @State private var showingDepositSheet = false
    @State private var showingConfigSheet = false
    
    var blockers: [Blocker] = BlockerList.mainBlockerList
    
    var body: some View {
        NavigationView {
            ChildView(istoday: $istoday, showingConfigSheet: $showingConfigSheet, showingDepositSheet: $showingDepositSheet, blockers: blockers)
            //                .toolbar {
            //                    ToolbarItemGroup(placement: .navigationBarLeading) {
            //                        HStack(spacing: 200) {
            //                            HStack{
            //                                CustomText(text: "Today",
            //                                           size: 20,
            //                                           weight: .bold,
            //                                           design: .default,
            //                                           color: .black)
            //
            //                                Toggle("today", isOn: $istoday)
            //                                    .labelsHidden()
            //                            }
            //
            //                            NavigationLink(
            //                                destination: UIBlockerLevel(),
            //                                label: {
            //                                    CustomSFImage(imageName: "person.crop.circle.badge.plus", width: 40, height: 40, corner: 0)
            //                                        .padding(.trailing, 20)
            //                                })
            //                        }
            //                    }
            //                }
        }
    }
}

struct ChildView: View {
    
    @Binding var istoday : Bool
    @Binding var showingConfigSheet: Bool
    @Binding var showingDepositSheet: Bool
    var blockers : [Blocker]
    
    var body: some View {
        VStack {
            List {
                ForEach(blockers, id: \.id) { blocker in
                    NavigationLink(
                        destination: UIDetail(blocker: blocker),
                        label: {
                            BlockerIndividual(blocker: blocker)
                        }
                    )
                }
                .onDelete(perform: { indexSet in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                })
                .onMove(perform: { indices, newOffset in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                })
                //.listRowBackground(Color.green) // list background color
                
                NavigationLink(
                    destination: UIAddBlocker1(),
                    label: {
                        CustomSFImage(imageName: "person.fill.badge.plus",
                                      width: 50,
                                      height: 50,
                                      corner: 0)
                            .padding(.leading, 120)
                    }
                )
            }
            .listStyle(GroupedListStyle())
            .toolbar {
                EditButton()
            }
            .offset(x: 0, y: 10)
            
            
            VStack {
                Spacer()
                
                Button{
                    showingConfigSheet.toggle()
                } label: {
                    CustomSFImage(imageName: "gearshape.fill",
                                  width: 30,
                                  height: 30,
                                  corner: 0)
                        .padding(.leading, 300)
                }
                .sheet(isPresented: $showingConfigSheet, content: {
                    UIConfig()
                })
            }
            
            VStack {
                Spacer()
                
                Button{showingDepositSheet.toggle()}
                    label: {
                        CustomSFImage(imageName: "dollarsign.square.fill",
                                      width: 120,
                                      height: 65,
                                      corner: 5)
                            .cornerRadius(38.5)
                            .padding()
                            .shadow(color: Color.black, radius: 3, x: 3, y: 3)
                    }
                    .sheet(isPresented: $showingDepositSheet, content: {
                        UIDeposit()
                    })
                
            }
        }
        //        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.orange]),
        //                                   startPoint: .topTrailing,
        //                                   endPoint: .bottomLeading))
        //        .accentColor(Color(.label))
        
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

struct UIMain_Previews: PreviewProvider {
    static var previews: some View {
        UIMain()
    }
}
