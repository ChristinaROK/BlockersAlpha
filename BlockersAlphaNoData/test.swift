//
//  test.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/06/06.
//

import SwiftUI

struct MainView: View {
    @State var people = [Person(name: "one", family: "1", type: "men"), Person(name: "two", family: "2", type: "women")]

    var body: some View {
        VStack {
            ForEach(self.people, id: \.self) { person in
                PersonView(person: person)
            }
        }
    }
}

struct Person: Hashable {
    var name: String
    var family: String
    var type: String
}

struct PersonView: View {
    let person: Person
    @State private var selection: Int?
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: Text(self.person.name),
                tag: self.person.hashValue + 1,
                selection: self.$selection) {

                EmptyView()
            }
            NavigationLink(
                destination: Text(self.person.type),
                tag: self.person.hashValue + 2,
                selection: self.$selection) {
                
                EmptyView()
            }
            
            Button("this is \(self.person.name) \(self.person.family)") {
                self.selection = self.person.hashValue + 1
            }
            Spacer()
            Button(self.person.type) {
                self.selection = self.person.hashValue + 2
            }.padding()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView()
        }
    }
}

struct PaddingTest: View {
    var body: some View {
        VStack {
            Text("SwiftUI")
                .padding(.leading, 200)
            Text("Rocks")
        }
    }
}

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button("Press to dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
//        .font(.title)
//        .padding()
//        .background(Color.black)
    }
}

struct SheetContentView: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, content: {
            SheetView()
        })
    }
    
}

//struct BlockerTest: View {
//    @State var blocker = BlockerList.mainBlockerList.first
//
//    var body: some View {
//        BlockerField(blocker: blocker)
//    }
//}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
                //BlockerTest()
        //PaddingTest()
        SheetContentView()
    }
}
