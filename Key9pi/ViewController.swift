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
    
    let userDefaults = UserDefaults(suiteName: "group.k9")

    @IBOutlet weak var wordTextField: UITextField!
    
    
    @IBOutlet var backgroundButtons: [UIButton]!
    
    @IBOutlet var buttonsButtons: [UIButton]!
    
    @IBOutlet var textButtons: [UIButton]!

    @IBAction func addWordsPressed(_ sender: UIButton) {
        if wordTextField.text! != "" {
            let text = wordTextField.text!.lowercased()
            
            if userDefaults?.object(forKey: "addWords") as? [String] != nil {
                var temp = userDefaults?.object(forKey: "addWords") as? [String] ?? [String]()
                temp.append(text)
                userDefaults?.set(temp, forKey: "addWords")
                userDefaults?.synchronize()
            } else {
                let arrayAdd = [text]
                userDefaults?.set(arrayAdd, forKey: "addWords")
                userDefaults?.synchronize()
            }
        }
    }
    
    

    @IBAction func delWordsPressed(_ sender: UIButton) {
        if wordTextField.text! != "" {
            let text = wordTextField.text!.lowercased()
            
            if userDefaults?.object(forKey: "delWords") as? [String] != nil {
                var temp = userDefaults?.object(forKey: "delWords") as? [String] ?? [String]()
                temp.append(text)
                userDefaults?.set(temp, forKey: "delWords")
                userDefaults?.synchronize()
                print(userDefaults?.object(forKey: "delWords") as? [String] ?? [String]())
            } else {
                let arrayDel = [text]
                userDefaults?.set(arrayDel, forKey: "delWords")
                userDefaults?.synchronize()
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func backgroundPress(_ sender: UIButton) {
        userDefaults?.set(sender.currentTitle! as AnyObject, forKey: "background")
        userDefaults?.synchronize()
        
        //change color of pressed button
        for button in backgroundButtons{
            button.backgroundColor = UIColor.black
           // button.setTitleColor(.white, for: .normal)
        }
        sender.backgroundColor = UIColor.blue
        
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
        userDefaults?.set(sender.currentTitle! as AnyObject, forKey: "button")
        userDefaults?.synchronize()
        
        //change color of pressed button
        for button in buttonsButtons{
            button.backgroundColor = UIColor.black
            // button.setTitleColor(.white, for: .normal)
        }
        sender.backgroundColor = UIColor.blue

    }
    
    @IBAction func textPress(_ sender: UIButton) {
        userDefaults?.set(sender.currentTitle! as AnyObject, forKey: "text")
        userDefaults?.synchronize()
        
        
        //change color of pressed button
        for button in textButtons{
            button.backgroundColor = UIColor.black
            // button.setTitleColor(.white, for: .normal)
        }
        sender.backgroundColor = UIColor.blue

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


