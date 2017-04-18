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

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @IBAction func addWordsPressed(_ sender: UIButton) {
        let currProfile = userDefaults?.object(forKey: "profile") as? String
        print(currProfile!)

        if wordTextField.text! != "" {
            let text = wordTextField.text!.lowercased()
            
            if userDefaults?.object(forKey: "addWords" + currProfile!) as? [String] != nil {
                var temp = userDefaults?.object(forKey: "addWords" + currProfile!) as? [String] ?? [String]()
                temp.append(text)
                userDefaults?.set(temp, forKey: "addWords" + currProfile!)
                userDefaults?.synchronize()
                print(userDefaults?.object(forKey: "addWords" + currProfile!) as? [String] ?? [String]())
            } else {
                let arrayAdd = [text]
                userDefaults?.set(arrayAdd, forKey: "addWords" + currProfile!)
                userDefaults?.synchronize()
                print(userDefaults?.object(forKey: "addWords" + currProfile!) as? [String] ?? [String]())
            }
            
            if userDefaults?.object(forKey: "delWords" + currProfile!) as? [String] != nil {
                var temp = userDefaults?.object(forKey: "delWords" + currProfile!) as? [String] ?? [String]()
                
                var offset = 0
                

                for (index, element) in temp.enumerated() {
                    if element == text {
                        print("deleting ", element, "at index ", index - offset)
                        temp.remove(at: index - offset)
                        offset += 1
                    }
                }
                
                userDefaults?.set(temp, forKey: "delWords" + currProfile!)
                userDefaults?.synchronize()
                //print(userDefaults?.object(forKey: "delWords" + currProfile!) as? [String] ?? [String]())
            }
        }
    }
    
    
    @IBAction func profilePressed(_ sender: UIButton) {
        
        var profile = "0"
        
        if sender.currentTitle == "Academic" {
            userDefaults?.set(profile, forKey: "profile")
            userDefaults?.synchronize()
        } else if sender.currentTitle == "Professional" {
            profile = "1"
            userDefaults?.set(profile, forKey: "profile")
            userDefaults?.synchronize()
        } else if sender.currentTitle == "Personal" {
            profile = "2"
            userDefaults?.set(profile, forKey: "profile")
            userDefaults?.synchronize()
        }
        
        highlightActiveProfile()
        
        let p = userDefaults?.object(forKey: "profile") as? String
        print(p)
    }
    
    

    @IBAction func delWordsPressed(_ sender: UIButton) {
        let currProfile = userDefaults?.object(forKey: "profile") as? String
        print(currProfile!)
        
        if wordTextField.text! != "" {
            let text = wordTextField.text!.lowercased()
            
            if userDefaults?.object(forKey: "delWords" + currProfile!) as? [String] != nil {
                var temp = userDefaults?.object(forKey: "delWords" + currProfile!) as? [String] ?? [String]()
                temp.append(text)
                userDefaults?.set(temp, forKey: "delWords" + currProfile!)
                userDefaults?.synchronize()
                print(userDefaults?.object(forKey: "delWords" + currProfile!) as? [String] ?? [String]())
            } else {
                let arrayDel = [text]
                userDefaults?.set(arrayDel, forKey: "delWords" + currProfile!)
                userDefaults?.synchronize()
            }
        }
    }
    
    @IBOutlet weak var academic: UIButton!
    @IBOutlet weak var professional: UIButton!
    @IBOutlet weak var personal: UIButton!
    
    func highlightActiveProfile() {
        let currProfile = userDefaults?.object(forKey: "profile") as? String
        
        if academic != nil {
            if currProfile == "0" {
                academic.backgroundColor = UIColor.blue;
                professional.backgroundColor = UIColor.black
                personal.backgroundColor = UIColor.black;

            } else if currProfile == "1" {
                academic.backgroundColor = UIColor.black;
                professional.backgroundColor = UIColor.blue;
                personal.backgroundColor = UIColor.black;

            } else if currProfile == "2" {
                academic.backgroundColor = UIColor.black;
                professional.backgroundColor = UIColor.black
                personal.backgroundColor = UIColor.blue;
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let profile = "0"
        userDefaults?.set(profile, forKey: "profile")
        userDefaults?.synchronize()
        
        highlightActiveProfile()

        
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


