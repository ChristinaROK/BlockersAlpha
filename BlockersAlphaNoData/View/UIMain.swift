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

struct UIMain: View {
    
    @State var istoday = false
    @State var showingDepositSheet = false
    @State var showingConfigSheet = false
    //@State var editMode = false
    @State var showingDeleteAlert = false
    @State var indexSet: IndexSet = []
    
    @EnvironmentObject var blockerViewModel : BlockerViewModel
    @EnvironmentObject var imageViewModel : ImageViewModel
    
    var body: some View {
        
        ZStack{
            
            //BackgroundColor(leadColor: Color.orange, trailColor: Color.green)
            
            VStack (spacing:10) {
                
                CustomText(text: "\(Date().formatDate()) 🗓 오늘도 부자에 한 걸음!", size: 20, weight: .light, design: .rounded, color: .fontOlive)
                    .padding(10)
                    .background(Color.backgroundOlive)
                
                List {
                    ForEach(blockerViewModel.currentBlockers) { blocker in
                        NavigationDetail(isToday: $istoday, blocker: blocker)
//                            .listRowBackground( // TODO: frame width 절대 수치를 상대 수치로 변환
//                                HStack(alignment: .top) {
//                                    RoundedRectangle(cornerRadius: 5)
//                                        .frame(width: 330*CGFloat(blocker.currentPercentage),
//                                            height: .infinity)
//                                        .background(Color.clear)
//                                        .foregroundColor(.red)
//                                        .opacity(0.2)
//                                        .padding(5)
//                                    Spacer()
//                                }
//
//                            )
                    }
                    .onMove(perform: blockerViewModel.moveBlocker)
                    .onDelete { indexSet in
                        self.indexSet = indexSet
                        showingDeleteAlert = true
                    }
                    .alert(isPresented: $showingDeleteAlert, content: {
                        Alert(title: Text("블로커 삭제"),
                              message: Text("블로커를 삭제하면 기존 데이터가 모두 삭제됩니다."),
                              primaryButton: .destructive(Text("삭제"), action: {
                                blockerViewModel.deleteBlocker(indexSet: self.indexSet)
                              }),
                              secondaryButton: .cancel(Text("취소")))
                    })
                    
                    //                        .onLongPressGesture {
                    //                            withAnimation {
                    //                                self.editMode = true
                    //                            }
                    //                        }
                    
                    NavigationAdd()
                }
                .listStyle(SidebarListStyle())
                //.environment(\.editMode, editMode ? .constant(.active) : .constant(.inactive))
                
                
                Spacer()
            }
            
            .offset(y:-50)
            
            SheetDeposit(showingDepositSheet: showingDepositSheet, blockerViewModel: blockerViewModel)
        }
        .navigationBarItems(leading:
                                HStack{
                                    CustomText(text: "Today",
                                               size: 17,
                                               weight: .bold,
                                               design: .default,
                                               color: .blue)
                                    
                                    Toggle("today", isOn: $istoday)
                                        .labelsHidden()
                                }
                                .padding(.vertical)
                            ,
                            trailing: EditButton())
        
    }
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
    
    @Binding var isToday: Bool
    @State var blocker: BlockerModel
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
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
                                   color: .fontOlive)
                            .lineLimit(1)
                            .padding(5)
                        
                        
                        VStack {
                            
                            if isToday {
                                
                                HStack { // 오른쪽 정렬
                                    Spacer()
                                    CustomText(text: "\(blocker.todayBudget.currencyRepresentation) 남음",
                                               size: 13,
                                               weight: .semibold,
                                               design: .rounded,
                                               color: .fontOlive)
                                    
                                }
                                
                                HStack {
                                    Spacer()
                                    CustomText(text: "\(blocker.dTime)시간 남음",
                                               size: 13,
                                               weight: .semibold,
                                               design: .rounded,
                                               color: .fontOlive)
                                }
                                
                            } else {
                                
                                HStack {
                                    Spacer()
                                    CustomText(text: "\(blocker.currentBudget.currencyRepresentation) 남음",
                                               size: 13,
                                               weight: .semibold,
                                               design: .rounded,
                                               color: .fontOlive)
                                }
                                
                                
                                HStack {
                                    Spacer()
                                    CustomText(text: "D-\(blocker.dDay)일 남음",
                                               size: 13,
                                               weight: .semibold,
                                               design: .rounded,
                                               color: .fontOlive)
                                }
                                
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        
                    }
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    //.background(Color.red.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.peripheralOlive, lineWidth: 2))
                }
            )
            
//            Text("\(blocker.currentPercentage)")
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.green.opacity(0.3))
                .frame(width: 300*CGFloat(blocker.currentPercentage), height: 100)
                
        }

    }
}

struct NavigationAdd: View {
    var body: some View {
        NavigationLink(
            destination: UICreateImageCopy(),
            label: {
                CustomSFImage(imageName: "person.crop.circle.badge.plus", renderMode: .template, width: 61, height: 52, color: .blockerOrange)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.peripheralOlive, lineWidth: 2))
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
    var blockerViewModel : BlockerViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Button{showingDepositSheet.toggle()}
                label: {
                    CustomSFImage(imageName: "plus.circle.fill", renderMode: .template, width: 80, height: 80, corner: 0, color: Color.lightAvocado)
                        .cornerRadius(38.5)
                        .shadow(color: Color.peripheralOlive, radius: 8, x: 3, y: 3)
                        .padding()
                }
                .sheet(isPresented: $showingDepositSheet, content: {
                    UIDeposit()
                        .environmentObject(blockerViewModel)
                    
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
