//
//  KeyboardViewController.swift
//  customKeyboard
//
//  Created by Michael on 3/7/17.
//  Copyright © 2017 EECS 481. All rights reserved.x
//

import UIKit

let path = Bundle.main.path(forResource: "comm-dict", ofType: "txt")
var trie = Trie()
var inString = ""

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trie.loadTrie(fileName: path!)
        
        //let defaults = UserDefaults.standard
        //let dict = defaults.object(forKey: "resultsDict")
        //print(dict!)
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    @IBAction func letterKeyPress(_ sender: UIButton) {
        if sender.currentTitle == "abc" {
            inString += "2"
        } else if sender.currentTitle == "def" {
            inString += "3"
        } else if sender.currentTitle == "ghi" {
            inString += "4"
        } else if sender.currentTitle == "jkl" {
            inString += "5"
        } else if sender.currentTitle == "mno" {
            inString += "6"
        } else if sender.currentTitle == "pqrs" {
            inString += "7"
        } else if sender.currentTitle == "tuv" {
            inString += "8"
        } else if sender.currentTitle == "wxyz" {
            inString += "9"
        }
        
        
        let tempDict = trie.getPossibilities(seq: inString, rootNode: trie.rootNode)
        print(tempDict.sorted(by: { (a, b) in (a.value) < (b.value) }))
    }
    
    @IBAction func backspacePress(_ sender: UIButton) {
        if inString.characters.count != 0 {
            let endIndex = inString.index(inString.endIndex, offsetBy: -1)
            inString = inString.substring(to: endIndex)
            
            let tempDict = trie.getPossibilities(seq: inString, rootNode: trie.rootNode)
            print(tempDict.sorted(by: { (a, b) in (a.value) < (b.value) }))
        } else {
            while textDocumentProxy.hasText {
                let tempDocText = textDocumentProxy.documentContextBeforeInput
                if tempDocText?.characters.last == " " {
                    textDocumentProxy.deleteBackward()
                    return
                } else {
                    textDocumentProxy.deleteBackward()
                }
            }
        }
    }
    
    @IBAction func spacePress(_ sender: UIButton) {
        textDocumentProxy.insertText(" ")
    }
    
    
    
}


