//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by eslam mohamed on 25/02/2022.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LeaguesModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    
    func insert(){}
    func update(){}
    func delete(){}
    func retrive(){}

    
    
    
    
    
    
    
//    func fetchDataN(){
//        let managedObjectContext = persistentContainer.viewContext
//        let fetchRequest         = NSFetchRequest<NSManagedObject>(entityName: "NewLeaugesEntity")
//        let arr = try! managedObjectContext.fetch(fetchRequest)
//        print(arr.count)
//        print(arr[0].value(forKey: "idLeague"))
//    }
    
    
//    func fetchData(){
//        let managedObjectContext = persistentContainer.viewContext
//        let fetchRequest         = NSFetchRequest<NSManagedObject>(entityName: "LeaugesEntity")
//        let arr = try! managedObjectContext.fetch(fetchRequest)
//        print(arr.count)
//        print(arr[0].value(forKey: "idLeague"))
//    }

    func fetchData()->[NSManagedObject]{
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest         = NSFetchRequest<NSManagedObject>(entityName: "LeaugesEntity")
        let arr = try! managedObjectContext.fetch(fetchRequest)
        print(arr.count)
        return arr
    }

    
    func saveData(leauges: Leagues){
        let managedObjectContext = persistentContainer.viewContext

        let entity       = NSEntityDescription.entity(forEntityName: "LeaugesEntity", in: managedObjectContext)!
        let league       = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        league.setValue(leauges.idLeague, forKey: "idLeague")
        league.setValue(leauges.strLeague, forKey: "strLeague")
        league.setValue(leauges.strLeagueAlternate, forKey: "strLeagueAlternate")
        league.setValue(leauges.strLogo, forKey: "strLogo")
        league.setValue(leauges.strYoutube, forKey: "strYoutube")
        league.setValue(leauges.strBadge, forKey: "strBadge")

        print("new LeaugesEntity saved")
        do{
            try managedObjectContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    
    func deleteData(leauges: Leagues){
        let managedObjectContext = persistentContainer.viewContext

        let entity       = NSEntityDescription.entity(forEntityName: "LeaugesEntity", in: managedObjectContext)!
        let league       = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        league.setValue(leauges.idLeague, forKey: "idLeague")
        league.setValue(leauges.strLeague, forKey: "strLeague")
        league.setValue(leauges.strLeagueAlternate, forKey: "strLeagueAlternate")
        league.setValue(leauges.strLogo, forKey: "strLogo")
        league.setValue(leauges.strYoutube, forKey: "strYoutube")
        league.setValue(leauges.strBadge, forKey: "strBadge")

        managedObjectContext.delete(league)
        saveContext()

    }
    
}
