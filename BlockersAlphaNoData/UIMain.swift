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
        ZStack {
            VStack {
                HStack(spacing: 200) {
                    Toggle(isOn: $istoday) {
                        Text("Today")
                    }
                    // todo: padding
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(5)
                        .scaledToFit() // ?
                        .padding(.horizontal, 10)
                }
                
                Spacer()
                
                NavigationView{
                    List(blockers, id: \.id) { blocker in
                        NavigationLink(
                            destination: UIDetail(blocker: blocker),
                            label: {
                                HStack {
                                    Image(blocker.image)
                                        .resizable()
                                        .frame(width: 100, height: 80, alignment: .center)
                                        .scaledToFit()
                                        .cornerRadius(50)
                                    
                                    VStack {
                                        Text("\(blocker.name)")
                                        Text("\(blocker.balance)")
                                    }
                                    
                                    Text("\(blocker.dDay)")
                                }
                            })
                        
                    }
                    
                    // to do : add navigationlink with button
                    
                    
                }
                .navigationTitle("blockers")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UIMain()
    }
}
