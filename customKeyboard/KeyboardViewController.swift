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
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var symView: UIView!
    @IBOutlet weak var numView: UIView!
    
    
    
    var shiftPressed = false
    var enterPressed = false
    var charCounter = 0
    
    func shiftOn() {
        shiftPressed = true;
        shiftButton.backgroundColor = UIColor.cyan;
    }
    
    func shiftOff() {
        shiftPressed = false;
        shiftButton.backgroundColor = UIColor.white
    }
    
    func resetSuggestions() {
        for button in wordButtons {
            button.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var shiftButton: UIButton!
    
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
            str =  str.uppercased()
            shiftPressed = false
            //shiftButton.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1);
            shiftButton.backgroundColor = UIColor.white
        }
//        if enterPressed {
//            str =  str.uppercased()
//            enterPressed = false
//        }
        (textDocumentProxy as UIKeyInput).insertText(str + " ")
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
        self.numView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        shiftOn()
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


