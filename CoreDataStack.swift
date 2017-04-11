//
//  CoreDataStack.swift
//  Key9pi
//
//  Created by Anna Hua on 3/29/17.
//  Copyright © 2017 EECS 481. All rights reserved.
//

import Foundation
import CoreData

let applicationGroupId = "group.Key9Pi"  // FIXME
let modelName = "Key9pi"
let storeName = "Key9pi.sqlite"

class CoreDataStack {
    static let sharedStack = CoreDataStack()

    func getDocumentsDirectory()-> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: modelName)
        let appName: String = "Key9Pi"
        var persistentStoreDescriptions: NSPersistentStoreDescription
        
        let storeUrl = self.getDocumentsDirectory().appendingPathComponent(storeName)
        
        if !FileManager.default.fileExists(atPath: (storeUrl.path)) {
            let seededDataUrl = Bundle.main.url(forResource: appName, withExtension: "sqlite")
            try! FileManager.default.copyItem(at: seededDataUrl!, to: storeUrl)
        }
        
        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.url = storeUrl
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - get context
    func getContext() -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /* -------------------------------- */
    
    func getWords(trie: Trie, rootNode: Node) {
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")

            if trie.isEmpty(rootNode: rootNode) {
                var count = 0
                //create a fetch request, telling it about the entity
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
                
                do {
                    //go get the results
                    let searchResults = try self.getContext().fetch(fetchRequest)
                    
                    //check the size of the returned results!
                    print ("num words in dictionary = \(searchResults.count)\n")
                    
                    //need to convert to NSManagedObject to use 'for' loops
                    for entry in searchResults {
                        //get the Key Value pairs
                        var word = ((entry as AnyObject).value(forKey: "word"))
                        print(word!)
                        word = (word as AnyObject).lowercased
                        trie.insert(word: word as! String, freq: count, rootNode: rootNode)
                        count += 1
                    }
                } catch {
                    print("Error with request: \(error)")
                    print("COULDN'T RETRIEVE DATA")
                }
            }
            
//            if let filepath = Bundle.main.path(forResource: "comm-dict", ofType: "txt")
//            {
//                do
//                {
//                    let contents = try String(contentsOfFile: filepath)
//                    let lines = contents.components(separatedBy: "\n")
//                    for line in lines {
//                        print(line)
//                        let trimmedLine = line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                        self.insert(word: trimmedLine.lowercased(), freq: 0, rootNode: self.rootNode)
//                    }
//                }
//                catch
//                {
//                    print("contents could not be loaded")
//                }
//            }
//            else {
//                print("Could not find file")
//            }
//            
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
            }
        }
    }
    
    func storeEntry (word: String) {
        let context = self.getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "Entry", in: context)
        
        let entry = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        entry.setValue(word, forKey: "word")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func deleteEntry(word: String) {
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        let predicate = NSPredicate(format: "word == %@", word)
        fetchRequest.predicate = predicate
        do {
            let fetchedEntities = try context.fetch(fetchRequest)
            for entity in fetchedEntities {  // There should only be one but fetchedEntities is a collection
                context.delete(entity as! NSManagedObject)
            }
        } catch {
            print("Could not fetch woof")
        }
        do {
            try context.save()
            print("deleted!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
