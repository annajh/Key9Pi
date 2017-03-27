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
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
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

