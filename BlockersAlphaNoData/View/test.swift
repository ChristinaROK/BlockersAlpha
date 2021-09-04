//
//  test.swift
//  BlockersAlphaNoData
//
//  Created by ssj on 2021/09/04.
//

import SwiftUI
import CoreData
import UIKit
 
public class CustomPeriodModel: NSObject, NSCoding {
    
    public func encode(with coder: NSCoder) {
       
    }
    
    public required init?(coder: NSCoder) {
        <#code#>
    }
    
    
}
//enum BlockerPeriodModel: String, CaseIterable, Equatable {
//    case weekly ,monthly, yearly
//}

class testCoreDataManager {
    
    static let instance = testCoreDataManager() // Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "BlockerContainer")
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("ERROR loading core data \(error)")
            }
        }
        
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("SUCESS save done")
        } catch let error {
            print("ERROR saving Core Data \(error)")
        }
    }
}

// View Model: CoreData(container)의 데이터 CRUD 작업
class testViewModel: ObservableObject {
    
    let manager = testCoreDataManager.instance
    @Published var test: [TestEntity] = []
    
    // Container에서 해당 entity를 가져와 (request) object에 할당
    init() {
        getTest()
    }
    
    func getTest() {
        let request = NSFetchRequest<TestEntity>(entityName: "TestEntity")
        
        do {
            test = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching Core Data \(error)")
        }
    }
    
    func addTest() {
        let newTest = TestEntity(context: manager.context)
        newTest.id = UUID()
        newTest.resetDate = DateComponents(day: 1)
        
        save()
    }
    
    func save() {
        self.manager.save() // CoreDate에 저장
        self.getTest() // ViewModel object 업데이트
    }
    
}


// View
struct test: View {
    
    @StateObject var vm = testViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {vm.addTest()},
                       label: {Text("Add!")
                        .foregroundColor(.white)
                        .bold()
                        .frame(height:55)
                        .frame(maxWidth:.infinity)
                        .background(Color.blue.cornerRadius(10))
                        .padding()
                       })
                
                VStack {
                    ForEach(vm.test) { test in
                        Text("\(test.id ?? UUID())")
                        Text("\(test.resetDate ?? DateComponents(day:7))")
                    }
                }
                
                
            }
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
