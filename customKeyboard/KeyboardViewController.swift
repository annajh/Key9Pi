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

   // @IBOutlet var nextKeyboardButton: UIButton!
    var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var symView: UIView!
    @IBOutlet weak var numView: UIView!
    
    var shiftPressed = false
    var enterPressed = false
    
    @IBOutlet weak var shiftButton: UIButton!
    
    
//    @IBOutlet weak var abcButton: UIButton!
//    @IBOutlet weak var defButton: UIButton!
//    @IBOutlet weak var ghiButton: UIButton!
//    @IBOutlet weak var jklButton: UIButton!
//    @IBOutlet weak var mnoButton: UIButton!
//    @IBOutlet weak var pqrsButton: UIButton!
//    @IBOutlet weak var tuvButton: UIButton!
//    @IBOutlet weak var wxyzButton: UIButton!
//    
    
    //let letterButtons: [UIButton] = [abcButton ];
    
    
    @IBAction func goToNum(_ sender: UIButton) {
        numView.isHidden = false
        textView.isHidden = true
        symView.isHidden = true
        
    }
    
    @IBAction func goToSym(_ sender: UIButton) {
        numView.isHidden = true
        textView.isHidden = true
        symView.isHidden = false
    }
    
    @IBAction func goToText(_ sender: UIButton) {
        numView.isHidden = true
        textView.isHidden = false
        symView.isHidden = true
    }
    
    @IBAction func globePress(_ sender: UIButton) {
        advanceToNextInputMode()
    }
    
    
    
    @IBAction func enterPress(_ sender: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
        enterPressed = true
    }
    
    
    @IBAction func spacePress(_ button: UIButton) {
        
        (textDocumentProxy as UIKeyInput).insertText(" ")
        
    }
    
    @IBAction func keyPress(_ button: UIButton) {
        
        var str = button.titleLabel!.text!
        let index = str.startIndex
        str = (String(str[index])).lowercased()
        //(textDocumentProxy as UIKeyInput).insertText("\(str[index])")
        if shiftPressed {
            str =  str.uppercased()
            shiftPressed = false
            shiftButton.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1);
        }
        if enterPressed {
            str =  str.uppercased()
            enterPressed = false
        }
        (textDocumentProxy as UIKeyInput).insertText(str)
        
    }
    
    @IBAction func shiftPress(_ sender: UIButton) {
        shiftPressed = true
        shiftButton.backgroundColor = UIColor.cyan;
        
    }
    
    
    @IBAction func backspacePressed(_ sender: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    

    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        setUpHeightConstraint();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trie.loadTrie(fileName: path!)
        
        //let defaults = UserDefaults.standard
        //let dict = defaults.object(forKey: "resultsDict")
        //print(dict!)
        
        // Perform custom UI setup here
        //self.nextKeyboardButton = UIButton(type: .system)
        
        //self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//        
//        self.view.addSubview(self.nextKeyboardButton)
//        
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
        
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    func setUpHeightConstraint()
    {
        let customHeight = UIScreen.main.bounds.height / 2.2
        
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: customHeight)
            heightConstraint.priority = UILayoutPriority(UILayoutPriorityRequired)
            
            view.addConstraint(heightConstraint)
        }
        else {
            heightConstraint.constant = customHeight
        }
    }
    
//    @IBAction func letterKeyPress(_ sender: UIButton) {
//        if sender.currentTitle == "abc" {
//            inString += "2"
//        } else if sender.currentTitle == "def" {
//            inString += "3"
//        } else if sender.currentTitle == "ghi" {
//            inString += "4"
//        } else if sender.currentTitle == "jkl" {
//            inString += "5"
//        } else if sender.currentTitle == "mno" {
//            inString += "6"
//        } else if sender.currentTitle == "pqrs" {
//            inString += "7"
//        } else if sender.currentTitle == "tuv" {
//            inString += "8"
//        } else if sender.currentTitle == "wxyz" {
//            inString += "9"
//        }
//        
//        
//        let tempDict = trie.getPossibilities(seq: inString, rootNode: trie.rootNode)
//        print(tempDict.sorted(by: { (a, b) in (a.value) < (b.value) }))
//    }
    
    @IBAction func letterKeyPress(_ sender: UIButton) {
        if sender.titleLabel!.text!.lowercased() == "abc" {
            inString += "2"
        } else if sender.titleLabel!.text!.lowercased() == "def" {
            inString += "3"
        } else if sender.titleLabel!.text!.lowercased() == "ghi" {
            inString += "4"
        } else if sender.titleLabel!.text!.lowercased() == "jkl" {
            inString += "5"
        } else if sender.titleLabel!.text!.lowercased() == "mno" {
            inString += "6"
        } else if sender.titleLabel!.text!.lowercased() == "pqrs" {
            inString += "7"
        } else if sender.titleLabel!.text!.lowercased() == "tuv" {
            inString += "8"
        } else if sender.titleLabel!.text!.lowercased() == "wxyz" {
            inString += "9"
        }
        
        
        let tempDict = trie.getPossibilities(seq: inString, rootNode: trie.rootNode, maxDepth: 1)
        print(tempDict.sorted(by: { (a, b) in (a.value) < (b.value) }))
    }

    
    @IBAction func backspacePress(_ sender: UIButton) {
        if inString.characters.count != 0 {
            let endIndex = inString.index(inString.endIndex, offsetBy: -1)
            inString = inString.substring(to: endIndex)
            
            let tempDict = trie.getPossibilities(seq: inString, rootNode: trie.rootNode, maxDepth: 1)
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
    
//    @IBAction func backspacePress(_ sender: UIButton) {
//        if inString.characters.count != 0 {
//            let endIndex = inString.index(inString.endIndex, offsetBy: -1)
//            inString = inString.substring(to: endIndex)
//            
//            let tempDict = trie.getPossibilities(seq: inString, rootNode: trie.rootNode)
//            print(tempDict.sorted(by: { (a, b) in (a.value) < (b.value) }))
//        } else {
//            while textDocumentProxy.hasText {
//                let tempDocText = textDocumentProxy.documentContextBeforeInput
//                if tempDocText?.characters.last == " " {
//                    textDocumentProxy.deleteBackward()
//                    return
//                } else {
//                    textDocumentProxy.deleteBackward()
//                }
//            }
//        }
//    }
    
    
    
}


