//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Mingyuan Zhou on 15/02/2017.
//  Copyright © 2017 Mingyuan Zhou. All rights reserved.
//

import UIKit
import Foundation

//let screenSize = UIScreen.main.bounds
//let screenWidth = Double(screenSize.width)
//let screenHeight = Double(screenSize.height)

/*  http://stackoverflow.com/questions/26961274/how-can-i-make-a-button-have-a-rounded-border-in-swift
*/
class CustomButton: UIButton {
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        //setBackgroundImage(UIImage(color: tintColor), forState: .Highlighted)
    }
}

var capsLockOn = true
var isNum = false

class KeyboardViewController: UIInputViewController {
    
//    func buttonAction(sender: AnyObject?) {
//        let button = sender as! UIButton
//        let title = button.title(for: .normal)
//        (textDocumentProxy as UIKeyInput).insertText(title!)
//    }
    
    /*
    func buttonPressed(sender: UIButton!) {
        
    }
    
    func createButtons(titles: [String]) -> [UIButton] {
        var buttons = [UIButton]()
        var index = 0
        for i in 0...3 {
            for j in 0...4 {
                let w = (screenWidth-30)/5
                let h = Double(216-30)/4
                let x = 5 + Double(j)*(w+5)
                let y = 6 + Double(i)*(h+6)
                var button: UIButton
                // set size of different buttons
                if index < 18 {
                    button = UIButton(frame: CGRect(x: x, y: y, width: w, height: h))
                }
                else {
                    button = UIButton(frame: CGRect(x: x, y: y, width: 2*w+6, height: h))
                }
                // set titles
                button.setTitle(titles[index], for: .normal)
                // set color of different buttons
                if index == 1 || index == 2 || index == 3 || index == 6 || index == 7 || index == 8 || index == 11 || index == 12 || index == 13 {
                    button.backgroundColor = UIColor.white
                }
                else {
                    button.backgroundColor = UIColor.lightGray
                }
                // add event for different buttons
                button.addTarget(self, action:#selector(self.buttonPressed), for: .touchUpInside)
                
                buttons.append(button)
                index += 1
                if index == 19 {
                    break
                }
            }
        }
        return buttons
    }*/
    /*
        let btn: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        btn.backgroundColor = UIColor.green
        btn.setTitle("Click Me", for: .normal)
        btn.addTarget(self, action: #selector(buttonAction), forControlEvents: .touchUpInside)
        btn.tag = 1
        self.view.addSubview(btn)
    */
    
//    func addConstraints(buttons: [UIButton], containingView: UIView){
//        
//        for (index, button) in buttons.enumerated() {
//            
//            let topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: containingView, attribute: .top, multiplier: 1.0, constant: 1)
//            
//            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: containingView, attribute: .bottom, multiplier: 1.0, constant: -1)
//            
//            var leftConstraint : NSLayoutConstraint!
//            
//            if index == 0 {
//                
//                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: containingView, attribute: .left, multiplier: 1.0, constant: 1)
//                
//            }else{
//                
//                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: buttons[index-1], attribute: .right, multiplier: 1.0, constant: 1)
//                
//                let widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
//                
//                containingView.addConstraint(widthConstraint)
//            }
//            
//            var rightConstraint : NSLayoutConstraint!
//            
//            if index == buttons.count - 1 {
//                
//                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: containingView, attribute: .right, multiplier: 1.0, constant: -1)
//                
//            }else{
//                
//                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: buttons[index+1], attribute: .left, multiplier: 1.0, constant: -1)
//            }
//            
//            containingView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
//        }
//    }
//
//    func createButtons(titles: [String]) -> [UIButton] {
//    
//        var buttons = [UIButton]()
//        
//        for title in titles {
//            let button = UIButton(type: .system)
//            button.setTitle(title, for: .normal)
//            button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
//            button.setTitleColor(UIColor.darkGray, for: .normal)
//            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//            buttons.append(button)
//        }
//        
//        return buttons
//    }
    
    
//    lazy var inputContainerView: UIView = {
//        let containerView = UIView()
//        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
//        containerView.backgroundColor = UIColor.lightGray
//        
//        let textField = UITextField()
//        textField.placeholder = "Enter Text"
//        containerView.addSubview(textField)
//        textField.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
//        return containerView
//    }()
//    private var keyboardInputView: UIToolbar {
//        let toolbar = UIToolbar()
//        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
//        toolbar.backgroundColor = UIColor.lightGray
//        //let completeItem = UIBarButtonItem(title: "Finish", style: .Done, target: self, action: "completeEditing:")
//        //let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        //toolbar.items = [space, completeItem]
//        return toolbar
//    }
    
    @IBAction func globePressed(button: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func keyPressed(button: UIButton) {
        let str = button.titleLabel!.text!
        let index = str.startIndex
        (textDocumentProxy as UIKeyInput).insertText("\(str[index])")
    }
    
    @IBAction func spacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func addWordPressed(button: UIButton) {
        if button.titleLabel!.text! == "0" {
            (textDocumentProxy as UIKeyInput).insertText("0")
        }
    }
    
    func changeToNums(containerView: UIView) {
        var index = 1
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let text = button.titleLabel!.text!
                if text == "123" || text == "ENG" || text == "\u{21E7}" || text == "\u{1F310}" || text == "\u{232B}" || text == "Return" || text == "Send" || text == "Space" {
                    continue
                }
                if index == 10 {
                    button.setTitle("\(0)", for: .normal)
                    break
                }
                let num = String(index)
                button.setTitle("\(num)", for: .normal)
                index += 1
            }
        }
    }
    
    @IBAction func numSwitchPressed(button: UIButton) {
        changeToNums(containerView: self.view)
        isNum = true
    }
    
    func changeToEng(containerView: UIView) {
        if isNum {
            for view in containerView.subviews {
                if let button = view as? UIButton {
                    let text = button.titleLabel!.text!
                    if capsLockOn {
                        switch text {
                        case "1":
                            button.setTitle("\(",._#")", for: .normal)
                        case "2":
                            button.setTitle("\("ABC")", for: .normal)
                        case "3":
                            button.setTitle("\("DEF")", for: .normal)
                        case "4":
                            button.setTitle("\("GHI")", for: .normal)
                        case "5":
                            button.setTitle("\("JKL")", for: .normal)
                        case "6":
                            button.setTitle("\("MNO")", for: .normal)
                        case "7":
                            button.setTitle("\("PQRS")", for: .normal)
                        case "8":
                            button.setTitle("\("TUV")", for: .normal)
                        case "9":
                            button.setTitle("\("WXYZ")", for: .normal)
                        case "0":
                            button.setTitle("\("Add Word")", for: .normal)
                        default: break
                        }
                    }
                    else {
                        switch text {
                        case "1":
                            button.setTitle("\(",._#")", for: .normal)
                        case "2":
                            button.setTitle("\("abc")", for: .normal)
                        case "3":
                            button.setTitle("\("edf")", for: .normal)
                        case "4":
                            button.setTitle("\("ghi")", for: .normal)
                        case "5":
                            button.setTitle("\("jkl")", for: .normal)
                        case "6":
                            button.setTitle("\("mno")", for: .normal)
                        case "7":
                            button.setTitle("\("pqrs")", for: .normal)
                        case "8":
                            button.setTitle("\("tuv")", for: .normal)
                        case "9":
                            button.setTitle("\("wxyz")", for: .normal)
                        case "0":
                            button.setTitle("\("Add Word")", for: .normal)
                        default: break
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func engSwitchPressed(button: UIButton) {
        changeToEng(containerView: self.view)
        isNum = false
    }
    
    func changeCaps(containerView: UIView) {
        if isNum {
            return
        }
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let text = button.titleLabel!.text!
                if text == "123" || text == "ENG" || text == "\u{21E7}" || text == "\u{1F310}" || text == "\u{232B}" || text == "Return" || text == "Send" || text == "Space" || text == "Add Word" {
                    continue
                }
                if capsLockOn {
                    button.setTitle("\(text.lowercased())", for: .normal)
                } else {
                    button.setTitle("\(text.uppercased())", for: .normal)
                }
            }
        }
        capsLockOn = !capsLockOn
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        changeCaps(containerView: self.view)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
//    override var inputAccessoryView: UIView {
//        get {
//            return inputContainerView
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = objects[0] as! UIView;
        
        let backButton = view.subviews[4] as! UIButton
        backButton.setTitle("\u{232B}", for: .normal)
        
        let shiftButton = view.subviews[10] as! UIButton
        shiftButton.setTitle("\u{21E7}", for: .normal)
        
        let globeButton = view.subviews[14] as! UIButton
        globeButton.setTitle("\u{1F310}", for: .normal)
        
        //width of each key: 375/5 = 75
        //height of each key: 220/4 = 55
        
        // Perform custom UI setup here
        
        //create buttons
        /*
        let buttonTitles = ["123", ",.?!", "DEF", "Backspace", "SHIFT", "GHI",
                            "JKL", "MNO", "CLEAR", "ADD", "PQRS", "TUV", "WXYZ",
                            "SPACE", "GLOBE", "QWERTY", "0", "ENTER"]
        let buttons = createButtons(titles: buttonTitles)
        for button in buttons {
            self.view.addSubview(button)
        }*/
        
        /*
        let button = UIButton(type: .system)
        //button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setTitle("TEST", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        */
//        
//        let buttonTitles = ["Q", "W", "E", "R", "T", "Y"]
//        
//        //let topRow = UIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:40))
//        var buttons = [UIButton]()
//        var index = 0
//        for i in 0...3 {
//                let button = UIButton()
//                print(0+10*Double(i))
//                button.frame = CGRect(x: 0+10*Double(i), y: 0, width: 10, height: 50)
//                button.setTitle(String(buttonTitles[index]), for: .normal)
//                button.translatesAutoresizingMaskIntoConstraints = false
//                button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
//                button.setTitleColor(UIColor.darkGray, for: .normal)
//                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//                buttons.append(button)
//                index += 1
//        }
//        
//        for button in buttons {
//            self.view.addSubview(button)
//        }
        
        //self.view.addSubview(topRow)
//        addConstraints(buttons: buttons, containingView: topRow)
        
        /*
        var topRow = UIView(frame: CGRectMake(0, 0, 320, 40))
        for (index, button) in buttons {
            topRow.addSubview(button)
        }
        addConstraints(buttons, containingView: topRow)
        */
        
        
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

}
