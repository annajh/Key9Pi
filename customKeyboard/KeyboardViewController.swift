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
var seq = SequenceModel()
let letters = CharacterSet.letters

class KeyboardViewController: UIInputViewController {

   // @IBOutlet var nextKeyboardButton: UIButton!
    var heightConstraint: NSLayoutConstraint!
    
    let myBlue = UIColor(red: 14/255, green: 0/255, blue: 211/255, alpha: 1)
    let maize = UIColor(red: 255/255, green: 250/255, blue: 0/255, alpha: 1)
    
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var symView: UIView!
    @IBOutlet weak var numView: UIView!
    @IBOutlet weak var downArrow: UIView!
    @IBOutlet weak var downArrow2: UIView!
    
    
    @IBOutlet var allTextButtons: [UIButton]!
    
    
    @IBOutlet var allArrowButtons: [UIButton]!
   
    @IBOutlet weak var shiftButton: UIButton!
    
    @IBOutlet var allButtons: [UIButton]!
    
    
    @IBAction func backFromArrow(_ sender: UIButton) {
        numView.isHidden = true
        textView.isHidden = false
        symView.isHidden = true
        downArrow.isHidden = true
    }
    
    @IBAction func downArrowPress(_ sender: UIButton) {
        numView.isHidden = true
        textView.isHidden = true
        symView.isHidden = true
        downArrow.isHidden = false
        downArrow2.isHidden = true
    }
    
    @IBAction func nextArrowPress(_ sender: UIButton) {
        numView.isHidden = true
        textView.isHidden = true
        symView.isHidden = true
        downArrow.isHidden = true
        downArrow2.isHidden = false
    }
    
    var shiftPressed = false
    var enterPressed = false
    var charCounter = 0
    lazy var shiftColor = UIColor()
    
    func shiftOn() {
        shiftPressed = true;
        //shiftButton.backgroundColor = UIColor.cyan;
        //shiftColor = shiftButton.backgroundColor!
        if(shiftButton.backgroundColor == UIColor.black){
            shiftButton.backgroundColor = UIColor.blue
        }
        else if (shiftButton.backgroundColor == UIColor.white){
            shiftButton.backgroundColor = UIColor.cyan
        }
        else if (shiftButton.backgroundColor == myBlue){
            shiftButton.backgroundColor = UIColor.black
        }
        else{
            //button is maize
            shiftButton.backgroundColor = UIColor.cyan
        }
    }
    
    func shiftOff() {
        shiftPressed = false;

        shiftButton.backgroundColor = shiftColor
    }
    
    func resetSuggestions() {
        for button in wordButtons {
            button.setTitle("", for: .normal)
        }
    }
    
    
    
    @IBOutlet var wordButtons: [UIButton]!
    //above is the array of the word buttons
    
    @IBAction func wordPress(_ sender: UIButton) {
//        while(charCounter>0){
//            textDocumentProxy.deleteBackward()
//            charCounter = charCounter - 1
//        }

        let str = sender.currentTitle!
        (textDocumentProxy as UIKeyInput).insertText(str + " ")
        seq.reset()
        
        trie.incrementFreq(word: str.lowercased(), rootNode: trie.rootNode)

        resetSuggestions()
    }
    
    
    
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
        //charCounter = 0
        shiftOn()
    }
    
    
    @IBAction func spacePress(_ button: UIButton) {
        
        (textDocumentProxy as UIKeyInput).insertText(" ")
        //charCounter = 0
        
    }
    
    @IBAction func keyPress(_ button: UIButton) {
        
        var str = button.titleLabel!.text!
        let index = str.startIndex
        str = (String(str[index])).lowercased()
        charCounter = charCounter + 1
        print(charCounter)
        //(textDocumentProxy as UIKeyInput).insertText("\(str[index])")
        if shiftPressed {
            //str =  str.uppercased()
            //shiftPressed = false
            //shiftButton.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1);
            //shiftButton.backgroundColor = UIColor.white
            shiftOff()
        }
//        if enterPressed {
//            str =  str.uppercased()
//            enterPressed = false
//        }
        if (numView.isHidden == false){
            (textDocumentProxy as UIKeyInput).insertText(str)
        }
        else{
            (textDocumentProxy as UIKeyInput).insertText(str + " ")
        }
        
        if str == "." || str == "!" || str == "?" {
            shiftOn()
        }
        
    }
    
    @IBAction func shiftPress(_ sender: UIButton) {
        shiftPressed ? shiftOff() : shiftOn()
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        setUpHeightConstraint();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        //self.numView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        shiftColor = shiftButton.backgroundColor!
        print("color of shift")
        print(shiftColor)
        
        shiftOn()
        trie.loadTrie(fileName: path!)
        
        if let userDefaults = UserDefaults(suiteName: "group.k9") {
            let background = userDefaults.string(forKey: "background")
            let button = userDefaults.string(forKey: "button")
            let text = userDefaults.string(forKey: "text")
            
            let addWords = userDefaults.object(forKey: "addWords") as? [String] ?? [String]()
            let delWords = userDefaults.object(forKey: "delWords") as? [String] ?? [String]()
            
            for word in addWords {
                trie.insert(word: word, freq: 1, rootNode: trie.rootNode)
            }
            
            for word in delWords {
                trie.deleteWord(word: word, rootNode: trie.rootNode)
            }
            
            
            if background == "White" {
                textView.backgroundColor = UIColor.white
                numView.backgroundColor = UIColor.white
                symView.backgroundColor = UIColor.white
                downArrow.backgroundColor = UIColor.white
                downArrow.backgroundColor = UIColor.white
            } else if background == "Black" {
                textView.backgroundColor = UIColor.black
                numView.backgroundColor = UIColor.black
                symView.backgroundColor = UIColor.black
                downArrow.backgroundColor = UIColor.black
                downArrow2.backgroundColor = UIColor.black
            } else if background == "Blue" {
                textView.backgroundColor = myBlue
                numView.backgroundColor = myBlue
                symView.backgroundColor = myBlue
                downArrow.backgroundColor = myBlue
                downArrow2.backgroundColor = myBlue
            } else if background == "Maize" {
                textView.backgroundColor = maize
                numView.backgroundColor = maize
                symView.backgroundColor = maize
                downArrow.backgroundColor = maize
                downArrow2.backgroundColor = maize
            }
            
            if button == "White" {
               
                for button in allButtons{
                    button.backgroundColor = UIColor.white
                }
                for button in allArrowButtons{
                    button.backgroundColor = UIColor.white
                }
                
            } else if button == "Black" {
            
                for button in allButtons{
                    button.backgroundColor = UIColor.black
                }
                for button in allArrowButtons{
                    button.backgroundColor = UIColor.black
                }
            } else if button == "Blue" {
             
                for button in allButtons{
                    button.backgroundColor = myBlue
                }
                for button in allArrowButtons{
                    button.backgroundColor = myBlue
                }
            } else if button == "Maize" {
               
                for button in allButtons{
                    button.backgroundColor = maize
                }
                for button in allArrowButtons{
                    button.backgroundColor = maize
                }
            }
            
            if text == "White" {
                for button in allButtons{
                    button.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
                for button in allArrowButtons{
                    button.setTitleColor(UIColor.white, for: UIControlState.normal)
                }

            } else if text == "Black" {
                for button in allButtons{
                    button.setTitleColor(UIColor.black, for: UIControlState.normal)
                }
                for button in allArrowButtons{
                    button.setTitleColor(UIColor.black, for: UIControlState.normal)
                }
            } else if text == "Blue" {
                for button in allButtons{
                    button.setTitleColor(myBlue, for: .normal)
                }
                for button in allArrowButtons{
                    button.setTitleColor(myBlue, for: .normal)
                }

            } else if text == "Maize" {
                for button in allButtons{
                    button.setTitleColor(maize, for: .normal)
                }
                for button in allArrowButtons{
                    button.setTitleColor(maize, for: .normal)
                }

            }
            
            
        }
     
        
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

    @IBAction func letterKeyPress(_ sender: UIButton) {
        let letterGroup = sender.titleLabel!.text!.lowercased()
        seq.push(button: letterGroup, cap: shiftPressed)
        print(seq.numSeq)
        
        let tempDict = trie.getPossibilities(seq: seq.numSeq, rootNode: trie.rootNode, maxDepth: 1)
        let sorted = tempDict.sorted(by: { (a, b) in (a.key.characters.count - a.value) < (b.key.characters.count - b.value) })
        print(sorted)
        displaySuggestions(results: sorted)
        
        shiftOff()
    }

    
    @IBAction func backspacePress(_ sender: UIButton) {
        //update charCounter here too
        if !seq.isEmpty() {
            seq.pop()
            if seq.isEmpty() {
                resetSuggestions()
                return
            }
            
            let tempDict = trie.getPossibilities(seq: seq.numSeq, rootNode: trie.rootNode, maxDepth: 1)
            let sorted = tempDict.sorted(by: { (a, b) in (a.key.characters.count - a.value) < (b.key.characters.count - b.value) })
            print(sorted)
            displaySuggestions(results: sorted)
        } else {
            while textDocumentProxy.hasText {  // Delete whole words.
                let tempDocText = textDocumentProxy.documentContextBeforeInput
                if letters.contains((tempDocText?.unicodeScalars.last)!) {
                    // Delete one character at a time if symbol/number.
                    textDocumentProxy.deleteBackward()
                } else {
                    textDocumentProxy.deleteBackward()
                    return
                }
            }
        }
    }
    
    func displaySuggestions(results: [(key:String,value:Int)]) {
        resetSuggestions()

        var wordcount = 0
        for button in wordButtons {
            if wordcount >= results.count { return }
            let word = results[wordcount].key
            button.setTitle(seq.addCapitalization(word: word), for: .normal)
            wordcount += 1
        }
    }
    
}


