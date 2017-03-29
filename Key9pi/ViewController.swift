//
//  ViewController.swift
//  Key9pi
//
//  Created by Michael on 3/7/17.
//  Copyright © 2017 EECS 481. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerMy: UIViewController {

    @IBOutlet weak var wordTextField: UITextField!
    

    @IBAction func addWordsPressed(_ sender: UIButton) {
        if (wordTextField.text?.isEmpty)! { return }
        let lowercase = wordTextField.text?.lowercased()

        if trie.isEmpty(rootNode: trie.rootNode) {
            trie.loadTrie(fileName: "comm-dict")
        }
        let wordlist = lowercase?.words
        for word in wordlist! {
            trie.insert(word: word, freq: 0, rootNode: trie.rootNode)
        }
    }
    
    
    // TODO: add button
    @IBAction func delWordsPressed(_ sender: UIButton) {
        if (wordTextField.text?.isEmpty)! { return }
        let lowercase = wordTextField.text?.lowercased()
        
        if trie.isEmpty(rootNode: trie.rootNode) {
            trie.loadTrie(fileName: "comm-dict")
        }
        let wordlist = lowercase?.words
        for word in wordlist! {
            trie.deleteWord(word: word, rootNode: trie.rootNode)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userDefaults = UserDefaults(suiteName: "group.k9") {
            userDefaults.set("default" as AnyObject, forKey: "color")
            userDefaults.set(2 as AnyObject, forKey: "other")
            userDefaults.synchronize()
        }
        
    self.hideKeyboardWhenTappedAround()
  
//        wordTextField.layer.borderColor = UIColor.black.cgColor;
//        wordTextField.layer.borderWidth = 2;
        
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        let fileURL = documentsURL?.appendingPathComponent("test.sqlite")

//        let defaults = UserDefaults.standard
//        var dict = [String: Int]()
//        dict["apple"] = 0;
//        defaults.set(dict, forKey: "resultsDict")
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }
   

    @IBAction func goBack(_ sender: UIButton) {
    self.dismiss(animated: true, completion: {});
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


 //Found this on stackoverflow, split by words, gets rid of punctuation and numbers.
extension String {
    var words: [String] {
        return components(separatedBy: .punctuationCharacters).joined()
            .components(separatedBy: " ")
            .filter{!$0.isEmpty}
    }
}


//found this on stack overflow
// http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


