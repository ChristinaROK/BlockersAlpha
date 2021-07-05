//
//  ContentView.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

struct UIMain: View {
  // TODO: child view로 옮기기
//    init() {
//        UITableView.appearance().separatorStyle = .none
//    }
    
    @State private var istoday = false
    @State private var showingDepositSheet = false
    @State private var showingConfigSheet = false
    
    @State var blockers: [Blocker] = BlockerList.mainBlockerList
    
    var body: some View {
        NavigationView {
            ChildView(showingConfigSheet: $showingConfigSheet, showingDepositSheet: $showingDepositSheet, blockers: blockers)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        HStack(spacing: 200) {
                            HStack{
                                CustomText(text: "Today",
                                           size: 20,
                                           weight: .bold,
                                           design: .default,
                                           color: .black)
                                
                                Toggle("today", isOn: $istoday)
                                    .labelsHidden()
                            }
                            
                            NavigationLink(
                                destination: UIBlockerLevel(),
                                label: {
                                    CustomSFImage(imageName: "person.crop.circle.badge.plus", width: 40, height: 40, corner: 0)
                                        .padding(.trailing, 20)
                                })
                        }
                    }
                }
        }
    }
}

struct ChildView: View {
    
    @Binding var showingConfigSheet: Bool
    @Binding var showingDepositSheet: Bool
    @State var blockers : [Blocker]
    @State var editMode = false
    
    var body: some View {
        ZStack {
            BackgroundColor(leadColor: Color.orange, trailColor: Color.green)
            
            VStack{
                // TODO: list height 늘리기
                List {
                    ForEach(blockers, content: { blocker in
                            NavigationLink(
                                destination: UIDetail(blocker: blocker),
                                label: {
                                    BlockerField(blocker: blocker)
                                }
                            )
                            .padding(5)
                    })
//                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .onLongPressGesture {
                        withAnimation {
                            self.editMode = true
                        }
                    }
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
                .listStyle(InsetGroupedListStyle())
                .environment(\.editMode, editMode ? .constant(.active) : .constant(.inactive))
                //                .toolbar {
                //                    EditButton()
                //                }
                .offset(x: 0, y: 20)
                
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
                .offset(x: -5, y: 300)
                
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
        }
    }
    
    func delete(indexSet: IndexSet) {
        blockers.remove(atOffsets: indexSet)
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        blockers.move(fromOffsets: indices, toOffset: newOffset)
        withAnimation {
            self.editMode = false
        }
    }
}

struct BlockerField: View {
    
    var blocker : Blocker
    
    var body: some View {
        HStack (spacing: 10) {
            CustomAssetsImage(imageName: blocker.image,
                              width: 100,
                              height: 80,
                              corner: 50)
            
            VStack {
                CustomText(text: blocker.name,
                           size: 30,
                           weight: .semibold,
                           design: .rounded,
                           color: .blue)
                CustomText(text: "\(blocker.balance)",
                           size: 20,
                           weight: .semibold,
                           design: .rounded,
                           color: .black)
            }
            
            CustomText(text: blocker.dDay,
                       size: 20,
                       weight: .semibold,
                       design: .rounded,
                       color: .black)
        }
    }
}

struct BackgroundColor: View {
    
    @State var leadColor: Color
    @State var trailColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [leadColor, trailColor]),
                       startPoint: .leading,
                       endPoint: .trailing)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct UIMain_Previews: PreviewProvider {
    static var previews: some View {
        UIMain()
        //BlockerField(blocker: BlockerList.mainBlockerList.first!)
    }
}
