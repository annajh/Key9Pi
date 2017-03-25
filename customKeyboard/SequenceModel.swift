//
//  SequenceModel.swift
//  Key9pi
//
//  Created by Anna Hua on 3/16/17.
//  Copyright © 2017 EECS 481. All rights reserved.
//

import Foundation

var buttonToNumber: [String:Int] = [
    "abc" : 2,
    "def" : 3,
    "ghi" : 4,
    "jkl" : 5,
    "mno" : 6,
    "pqrs" : 7,
    "tuv" : 8,
    "wxyz" : 9
]

class SequenceModel {
    var numSeq = ""
    var capSeq: [Bool] = []
    
    func push(button: String, cap: Bool) {
        numSeq = numSeq + "\(buttonToNumber[button])"
        capSeq.append(cap)
    }
    
    func pop() {
        numSeq.remove(at: numSeq.index(before: numSeq.endIndex))
        capSeq.removeLast()
    }
    
    func addCapitalization(word: String) -> String {
        var newStr = word
        for i in 0..<capSeq.capacity {
            let c = word[word.index(word.startIndex, offsetBy: i)]
            newStr.append(capSeq[i] ? String(c).uppercased() : String(c))
        }
        return newStr
    }
}
