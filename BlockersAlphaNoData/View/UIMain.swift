//
//  ContentView.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

// TODO
// 2. NavigiationDetail View에서 HStack 내 간격 맞추기
// 3. background color 넣기 (현재 오류 발생)

struct UIMain: View {
    
    @State private var istoday = false
    @State private var showingDepositSheet = false
    @State private var showingConfigSheet = false
    @State var editMode = false
    
    @State var blockers: [Blocker] = BlockerList.mainBlockerList
    
    var body: some View {
        NavigationView {
            ZStack{
                //BackgroundColor(leadColor: Color.orange, trailColor: Color.green)
                
                List {
                    ForEach(blockers) { blocker in
                        NavigationDetail(blocker: blocker)
                    }
                    .onMove(perform: move)
                    .onLongPressGesture {
                        withAnimation {
                            self.editMode = true
                        }
                    }
                    
                    NavigationAdd()
                }
                .listStyle(SidebarListStyle())
                .environment(\.editMode, editMode ? .constant(.active) : .constant(.inactive))
                
                SheetConfig(showingConfigSheet: showingConfigSheet)
                
                SheetDeposit(showingDepositSheet: showingDepositSheet)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    HStack(spacing: 180) {
                        HStack{
                            CustomText(text: "Today",
                                       size: 20,
                                       weight: .bold,
                                       design: .default,
                                       color: .black)
                            
                            Toggle("today", isOn: $istoday)
                                .labelsHidden()
                        }
                        .padding()
                        
                        NavigationLink(
                            destination: UIBlockerLevel(),
                            label: {
                                CustomSFImage(imageName: "bag.circle.fill", renderMode: .template, width: 50, height: 50, color: Color.green)
                                    .padding(.trailing, 30)
                            })
                    }
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

struct NavigationDetail: View {
    
    @State var blocker: Blocker
    
    var body: some View {
        NavigationLink(
            destination: UIDetail(blocker: blocker),
            label: {
                HStack (spacing: 40) {
                    CustomAssetsImage(imageName: blocker.image,
                                      width: 80,
                                      height: 80,
                                      corner: 0)
                    
                    VStack {
                        CustomText(text: blocker.name,
                                   size: 25,
                                   weight: .semibold,
                                   design: .rounded,
                                   color: .blue)
                        CustomText(text: "\(blocker.balance)",
                                   size: 15,
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
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 2))
            }
        )
    }
}

struct NavigationAdd: View {
    var body: some View {
        NavigationLink(
            destination: UIAddBlocker1(),
            label: {
                CustomSFImage(imageName: "person.fill.badge.plus", renderMode: .original, width: 50, height: 50, color: Color.orange)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 2))
            }
        )
    }
}

struct SheetConfig: View {
    
    @State var showingConfigSheet: Bool
    
    var body: some View {
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
    }
}

struct SheetDeposit: View {
    
    @State var showingDepositSheet: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Button{showingDepositSheet.toggle()}
                label: {
                    CustomSFImage(imageName: "dollarsign.square.fill", renderMode: .template, width: 100, height: 80, corner: 0, color: Color.green)
                        .cornerRadius(38.5)
                        .shadow(color: Color.green, radius: 3, x: 3, y: 3)
                        .padding()
                }
                .sheet(isPresented: $showingDepositSheet, content: {
                    UIDeposit()
                })
        }
    }
}

struct UIMain_Previews: PreviewProvider {
    static var previews: some View {
        UIMain()
    }
}
