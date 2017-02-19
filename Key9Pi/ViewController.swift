//
//  ViewController.swift
//  Key9Pi
//
//  Created by Anna Hua on 2/14/17.
//  Copyright © 2017 EECS481. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var inString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var trie = Trie()
    private let rootNode = Node()
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getWords () {
        if trie.isEmpty(rootNode: rootNode) {
            var count = 0
            //create a fetch request, telling it about the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
            
            do {
                //go get the results
                let searchResults = try getContext().fetch(fetchRequest)
                
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
                //print("Error with request: \(error)")
            }
        }
    }

    
    func storeEntry (word: String) {
        let context = getContext()
        
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
    
    @IBOutlet weak var seqInput: UITextField!
    
    @IBOutlet weak var wordSuggestions: UITextField!
    
    
    @IBAction func printCoreData(_ sender: UIButton) {
//        getWords()
//        wordSuggestions.text = ""
//        
//        if seqInput != nil {
//            let results = trie.getPossibilities(seq: seqInput.text!, rootNode: rootNode)
//            
//            print("results for query:")
//            for word in results {
//                print(word.key, terminator:" ")
//                wordSuggestions.text?.append(word.key + " ")
//            }
//        }
//        //117, 32445, 17, 8233142 -> good examples
    }
    
    @IBAction func keyPress(_ sender: UIButton) {
        getWords()
        wordSuggestions.text = ""
        
        if sender.currentTitle == "abc" {
            inString = inString + "1"
        } else if sender.currentTitle == "stu" {
            inString = inString + "7"
        }
        
        let results = trie.getPossibilities(seq: inString, rootNode: rootNode)
        
        for word in results {
            print(word.key, terminator:" ")
            wordSuggestions.text?.append(word.key + " ")
        }
    }
    
}


