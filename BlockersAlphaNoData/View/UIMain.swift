//
//  ContentView.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/04.
//

import SwiftUI

// TODO
// 1. button 과 long press gesture 같이 잇으니깐 인식 못함. 개선해야함
// 2. NavigiationDetail View에서 HStack 내 간격 맞추기
// 3. background color 넣기 (현재 오류 발생)

struct UIMain: View {
    
    @State var istoday = false
    @State var showingDepositSheet = false
    @State var showingConfigSheet = false
    @State var editMode = false
    
    @EnvironmentObject var blockerViewModel : BlockerViewModel
    
    var body: some View {
            ZStack{
                
                //BackgroundColor(leadColor: Color.orange, trailColor: Color.green)
                
                VStack (spacing:20) {
                    
                    CustomText(text: "\(Date().formatDate()) 🗓 오늘도 부자에 한 걸음!", size: 20, weight: .light, design: .rounded, color: .white)
                    .padding(5)
                    .background(Color.green)
                    .offset(y: -35)
                    
                    List {
                        ForEach(blockerViewModel.currentBlockers) { blocker in
                            NavigationDetail(blocker: blocker)
                        }
                        .onMove(perform: blockerViewModel.moveBlocker)
                        .onDelete(perform: blockerViewModel.deleteBlocker)
//                        .onLongPressGesture {
//                            withAnimation {
//                                self.editMode = true
//                            }
//                        }
                        
                        NavigationAdd()
                    }
                    .listStyle(SidebarListStyle())
//                    .environment(\.editMode, editMode ? .constant(.active) : .constant(.inactive))
                    .offset(y:-50)
                    
                    
                    Spacer()
                }
                
                SheetConfig(showingConfigSheet: showingConfigSheet)
                
                SheetDeposit(showingDepositSheet: showingDepositSheet)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    HStack(spacing: 160) {
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
                                    CustomAssetsImage(imageName: "icon-shop-blocker", width: 40 , height: 40, corner: 0)
                                        .offset(y:5)
                                        .padding(.trailing, 20)
                            })
                    }
                }
            }
        
    }
    
//    func move(indices: IndexSet, newOffset: Int) {
//        blockers.move(fromOffsets: indices, toOffset: newOffset)
//        withAnimation {
//            self.editMode = false
//        }
//    }
}


struct BackgroundColor: View {
    
    @State var leadColor: Color
    @State var trailColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [leadColor, trailColor]),
                       startPoint: .leading,
                       endPoint: .trailing)
                        .ignoresSafeArea()
    }
}

struct NavigationDetail: View {
    
    @State var blocker: BlockerModel
    
    var body: some View {
        NavigationLink(
            destination: UIDetail(blocker: blocker),
            label: {
                HStack (spacing: 5) {
                    CustomAssetsImage(imageName: blocker.image,
                                      width: 110,
                                      height: 80,
                                      corner: 0)
                        .padding(5)
                    
                    CustomText(text: blocker.name,
                               size: 20,
                               weight: .semibold,
                               design: .rounded,
                               color: .blue)
                        .lineLimit(1)
                        .padding(5)
                    
                    VStack {
                        CustomText(text: "\(blocker.currentBudget.currencyRepresentation) 남음",
                                   size: 13,
                                   weight: .semibold,
                                   design: .rounded,
                                   color: .black)
                            .padding(.vertical, 3)
//                        CustomText(text: "\(blocker.dDay)일 남음",
//                                   size: 13,
//                                   weight: .semibold,
//                                   design: .rounded,
//                                   color: .black)
                    }
                    
                    
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
            destination: UICreateImage(),
            label: {
                CustomSFImage(imageName: "person.crop.circle.fill.badge.plus", renderMode: .original, width: 61, height: 52, color: Color.orange)
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
                    CustomSFImage(imageName: "plus.circle.fill", renderMode: .template, width: 80, height: 80, corner: 0, color: Color.green)
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
        NavigationView {
            UIMain()
        }
        .environmentObject(BlockerViewModel())
        .environmentObject(ImageViewModel())
        
    }
}
