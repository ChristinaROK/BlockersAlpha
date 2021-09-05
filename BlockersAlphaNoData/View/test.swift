////
////  test.swift
////  BlockersAlphaNoData
////
////  Created by ssj on 2021/09/04.
////
//
//import SwiftUI
//import CoreData
//
//class testCoreDataManager {
//    
//    static let instance = testCoreDataManager() // Singleton
//    let container: NSPersistentContainer
//    let context: NSManagedObjectContext
//    
//    init() {
//        container = NSPersistentContainer(name: "BlockerContainer")
//        container.loadPersistentStores { (desc, error) in
//            if let error = error {
//                print("ERROR loading core data \(error)")
//            }
//        }
//        
//        context = container.viewContext
//    }
//    
//    func save() {
//        do {
//            try context.save()
//            print("SUCESS save done")
//        } catch let error {
//            print("ERROR saving Core Data \(error)")
//        }
//    }
//}
//
//// View Model: CoreData(container)의 데이터 CRUD 작업
//class testViewModel: ObservableObject {
//    
//    let manager = testCoreDataManager.instance
//    @Published var test: [TestEntity] = []
//    //@Published var histories: [HistoryEntity] = []
//    
//    // Container에서 해당 entity를 가져와 (request) object에 할당
//    init() {
//        getTest()
//    }
//    
//    func getTest() {
//        let request = NSFetchRequest<TestEntity>(entityName: "TestEntity")
//        
//        do {
//            test = try manager.context.fetch(request)
//            print("SUCESS fetcing Core Data")
//        } catch let error {
//            print("Error fetching Core Data \(error)")
//        }
//    }
//    
////    func getHistories() {
////        let request = NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
////
////        do {
////            histories = try manager.context.fetch(request)
////            print("SUCESS fetcing Core Data")
////        } catch let error {
////            print("Error fetching Core Data \(error)")
////        }
////    }
//    
//    
//    func addTest() {
//        let newTest = TestEntity(context: manager.context)
//        newTest.id = UUID()
//        newTest.name = "Christina"
//        newTest.budget = 200000
//        newTest.spent = 100000
//        
//        save()
//    }
//    
//    func addHistory(test: TestEntity) {
//        let newHistory = HistoryEntity(context: manager.context)
//        newHistory.date = Date()
//        newHistory.spend = 10000
//        newHistory.notes = "Lunch Meal"
//        newHistory.test = test
//        print("\(test)")
//        
//        //newHistory.addToTest(value: TestEntity)
//        
//        save()
//    }
//    
//    func updateTest(additionalSpent:Float) {
//        test[0].spent += additionalSpent
//        
//        save()
//    }
//    
//    func popTest() {
//        guard let popTest = test.last //Optional
//        else { return }
//        manager.context.delete(popTest)
//        save()
//        
//    }
//    
//    func save() {
//        test.removeAll()
//        
//        self.manager.save() // CoreDate에 저장
//        self.getTest() // ViewModel object 업데이트
//    }
//    
//}
//
//
//// View
//struct Test: View {
//    
//    @StateObject var vm = testViewModel()
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Button(action: {vm.addTest()},
//                       label: {Text("Add!")
//                        .foregroundColor(.white)
//                        .bold()
//                        .frame(height:55)
//                        .frame(maxWidth:.infinity)
//                        .background(Color.blue.cornerRadius(10))
//                        .padding()
//                       })
//                
//                Button(action: {vm.updateTest(additionalSpent: 100000)},
//                       label: {Text("Spent!")
//                        .foregroundColor(.green)
//                        .bold()
//                        .frame(height:55)
//                        .frame(maxWidth:.infinity)
//                        .background(Color.blue.cornerRadius(10))
//                        .padding()
//                       })
//                
//                Button(action: {vm.popTest()},
//                       label: {Text("Remove Last!")
//                        .foregroundColor(.red)
//                        .bold()
//                        .frame(height:55)
//                        .frame(maxWidth:.infinity)
//                        .background(Color.blue.cornerRadius(10))
//                        .padding()
//                       })
//                
//                Button(action: {vm.addHistory(test: vm.test[0])},
//                       label: {Text("add history")
//                        .foregroundColor(.white)
//                        .bold()
//                        .frame(height:55)
//                        .frame(maxWidth:.infinity)
//                        .background(Color.blue.cornerRadius(10))
//                        .padding()
//                       })
//                
//                ScrollView(showsIndicators: true) {
//                    VStack(spacing: 20) {
//                        ForEach(vm.test) { test in
//                            //Text("\(test.id)")
//                            Text("Name : \(test.name)")
//                            Text("Budget : \(test.budget) Spent : \(test.spent)")
//                            Text("currentBudget: \(test.currentBudget)")
//                            
//                            // DownCasting using 'as?'
////                            if let histories = test.histories?.allObjects as? [HistoryEntity] {
////                                ForEach(histories) { history in
////                                    Text("History: \(history)")
////                                }
////                            }
//                            
//                            
//                        }
//                    }
//                }
//
//                
//                
//            }
//        }
//    }
//}
//
//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        Test()
//    }
//}
