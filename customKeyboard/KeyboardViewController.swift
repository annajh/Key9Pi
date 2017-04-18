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
    
    func updateDict() {
        if let userDefaults = UserDefaults(suiteName: "group.k9") {
            let currProfile = userDefaults.object(forKey: "profile") as? String
            var otherProfile1 = ""
            var otherProfile2 = ""
            
            if currProfile == "0" {
                otherProfile1 = "1"
                otherProfile2 = "2"
            } else if currProfile == "1"{
                otherProfile1 = "0"
                otherProfile2 = "2"
            } else if currProfile == "2" {
                otherProfile1 = "0"
                otherProfile2 = "1"
            }
            
            let del1 = userDefaults.object(forKey: "addWords" + otherProfile1) as? [String] ?? [String]()
            let del2 = userDefaults.object(forKey: "addWords" + otherProfile2) as? [String] ?? [String]()
            
            for word in del1 {
                trie.deleteWord(word: word, rootNode: trie.rootNode)
            }
            
            for word in del2 {
                trie.deleteWord(word: word, rootNode: trie.rootNode)
            }
            
            //////////
            
            let addWords = userDefaults.object(forKey: "addWords" + currProfile!) as? [String] ?? [String]()
            let delWords = userDefaults.object(forKey: "delWords" + currProfile!) as? [String] ?? [String]()
            
            for word in addWords {
                trie.insert(word: word, freq: 1, rootNode: trie.rootNode)
            }
            
            for word in delWords {
                trie.deleteWord(word: word, rootNode: trie.rootNode)
            }
        }
        
    }
    
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
    @IBOutlet var allArrowButtons2: [UIButton]!
   
    @IBOutlet weak var shiftButton: UIButton!
    
    @IBOutlet var allButtons: [UIButton]!
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton2: UIButton!
    
    //for custom qwerty only
    @IBOutlet weak var qwertyView:
    UIView!
    
    
    @IBAction func qwertyWordPress(_ sender: UIButton) {
        let str = sender.titleLabel!.text!
      (textDocumentProxy as UIKeyInput).insertText("\(str)")
    }
    
    @IBAction func qwertyBackPressed(_ sender: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func qwertyAddPress(_ sender: UIButton) {
        //to implement
//        let text = (textDocumentProxy as UIKeyInput)
//        trie.insert(word: text as! String, freq: 1, rootNode: trie.rootNode)
    }
    
    @IBAction func qwertyReturnPressed(_ sender: UIButton) {
        qwertyView.isHidden = true
        numView.isHidden = true
        textView.isHidden = false
        symView.isHidden = true
        downArrow.isHidden = true
        downArrow2.isHidden = true
    }
    
    @IBAction func downArrowPress(_ sender: UIButton) {
        qwertyView.isHidden = true
        numView.isHidden = true
        textView.isHidden = true
        symView.isHidden = true
        downArrow.isHidden = false
        downArrow2.isHidden = true
        
        
    }
    
    @IBAction func nextArrowPress(_ sender: UIButton) {
        qwertyView.isHidden = true
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
        for button in allArrowButtons {
            button.setTitle("", for: .normal)
        }
        for button in allArrowButtons2 {
            button.setTitle("", for: .normal)
        }

    }
    
    
    
    @IBOutlet var wordButtons: [UIButton]!
    //above is the array of the word buttons
    
    @IBAction func wordPress(_ sender: UIButton) {

        let str = sender.currentTitle!
        (textDocumentProxy as UIKeyInput).insertText(str + " ")
        seq.reset()
        
        trie.incrementFreq(word: str.lowercased(), rootNode: trie.rootNode)

        resetSuggestions()
        
        goToText(sender)
    }
    
    
    @IBAction func goToNum(_ sender: UIButton) {
        seq.reset()
        numView.isHidden = false
        textView.isHidden = true
        symView.isHidden = true
        
    }
    
    @IBAction func goToSym(_ sender: UIButton) {
        seq.reset()
        numView.isHidden = true
        textView.isHidden = true
        symView.isHidden = false
    }
    
    @IBAction func goToText(_ sender: UIButton) {
        seq.reset()
        numView.isHidden = true
        textView.isHidden = false
        symView.isHidden = true
        downArrow.isHidden = true
        downArrow2.isHidden = true
    }
    
    @IBAction func goToAdd(_ sender: UIButton) {
        seq.reset()
        qwertyView.isHidden = false
        numView.isHidden = true
        textView.isHidden = true
        symView.isHidden = true
        downArrow.isHidden = true
        downArrow2.isHidden = true
    }
    
    @IBAction func globePress(_ sender: UIButton) {
        seq.reset()
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
        
        if shiftPressed {
          
            shiftOff()
        }

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
        
        shiftOn()
        trie.loadTrie(fileName: path!)
        
        if let userDefaults = UserDefaults(suiteName: "group.k9") {
            let background = userDefaults.string(forKey: "background")
            let button = userDefaults.string(forKey: "button")
            let text = userDefaults.string(forKey: "text")
            
            self.updateDict()
            
            if background == "White" {
                textView.backgroundColor = UIColor.white
                numView.backgroundColor = UIColor.white
                symView.backgroundColor = UIColor.white
                downArrow.backgroundColor = UIColor.white
                downArrow2.backgroundColor = UIColor.white
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
                for button in allArrowButtons2{
                    button.backgroundColor = UIColor.white
                }
                backButton.backgroundColor = UIColor.white
                backButton2.backgroundColor = UIColor.white
                nextButton.backgroundColor = UIColor.white
                
            } else if button == "Black" {
            
                for button in allButtons{
                    button.backgroundColor = UIColor.black
                }
                for button in allArrowButtons{
                    button.backgroundColor = UIColor.black
                }
                for button in allArrowButtons2{
                    button.backgroundColor = UIColor.black
                }
                backButton.backgroundColor = UIColor.black
                backButton2.backgroundColor = UIColor.black
                nextButton.backgroundColor = UIColor.black
                
            } else if button == "Blue" {
             
                for button in allButtons{
                    button.backgroundColor = myBlue
                }
                for button in allArrowButtons{
                    button.backgroundColor = myBlue
                }
                for button in allArrowButtons2{
                    button.backgroundColor = myBlue
                }
                backButton.backgroundColor = myBlue
                backButton2.backgroundColor = myBlue
                nextButton.backgroundColor = myBlue
                
            } else if button == "Maize" {
               
                for button in allButtons{
                    button.backgroundColor = maize
                }
                for button in allArrowButtons{
                    button.backgroundColor = maize
                }
                for button in allArrowButtons2{
                    button.backgroundColor = maize
                }
                backButton.backgroundColor = maize
                backButton2.backgroundColor = maize
                nextButton.backgroundColor = maize
            }
            
            if text == "White" {
                for button in allButtons{
                    button.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
                for button in allArrowButtons{
                    button.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
                for button in allArrowButtons2{
                    button.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
                backButton.setTitleColor(UIColor.white, for: UIControlState.normal)
                backButton2.setTitleColor(UIColor.white, for: UIControlState.normal)
                nextButton.setTitleColor(UIColor.white, for: UIControlState.normal)

            } else if text == "Black" {
                for button in allButtons{
                    button.setTitleColor(UIColor.black, for: UIControlState.normal)
                }
                for button in allArrowButtons{
                    button.setTitleColor(UIColor.black, for: UIControlState.normal)
                }
                for button in allArrowButtons2{
                    button.setTitleColor(UIColor.black, for: UIControlState.normal)
                }

                backButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                backButton2.setTitleColor(UIColor.black, for: UIControlState.normal)
                nextButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                
            } else if text == "Blue" {
                for button in allButtons{
                    button.setTitleColor(myBlue, for: .normal)
                }
                for button in allArrowButtons{
                    button.setTitleColor(myBlue, for: .normal)
                }
                for button in allArrowButtons2{
                    button.setTitleColor(myBlue, for: .normal)
                }

                backButton.setTitleColor(myBlue, for: .normal)
                backButton2.setTitleColor(myBlue, for: .normal)
                nextButton.setTitleColor(myBlue, for: .normal)

            } else if text == "Maize" {
                for button in allButtons{
                    button.setTitleColor(maize, for: .normal)
                }
                for button in allArrowButtons{
                    button.setTitleColor(maize, for: .normal)
                }
                for button in allArrowButtons2{
                    button.setTitleColor(maize, for: .normal)
                }
                backButton.setTitleColor(maize, for: .normal)
                backButton2.setTitleColor(maize, for: .normal)
                nextButton.setTitleColor(maize, for: .normal)

            }
            
            
        }
        shiftColor = shiftButton.backgroundColor!
        print("color of shift")
        print(shiftColor)
        
        shiftOn()


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
        displayArrowSuggestions(results: sorted)
        
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
            displayArrowSuggestions(results: sorted)
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
    
    //func for displaying word choices in down arrow views
    func displayArrowSuggestions(results: [(key:String,value:Int)]) {
        //resetSuggestions()
        print("in arrow view 1")
        
        var wordcount = 3; //starts from 3rd word
      
        
        // -3 because 3 word suggestions appear in main keyboard?
        let numSuggestions = results.count
     
        
        for button in allArrowButtons {
            if wordcount >= numSuggestions{
                return
            }
            let word = results[wordcount].key
            
            button.setTitle(seq.addCapitalization(word: word), for: .normal)
            wordcount += 1
        }
        if numSuggestions < 21 {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
            return
        }
        nextButton.isEnabled = true
        nextButton.alpha = 1;
        print("over 21...")
        //fill next view
        for button in allArrowButtons2 {
            if wordcount >= numSuggestions{
                return
            }
            let word = results[wordcount].key
            
            button.setTitle(seq.addCapitalization(word: word), for: .normal)
            wordcount += 1
        }

        
    }
    
}


