//
//  SequenceModel.swift
//  Key9pi
//
//  Created by Anna Hua on 3/16/17.
//  Copyright © 2017 EECS 481. All rights reserved.
//

import Foundation

let buttonToNumber: [String:String] = [
    "abc" : "2",
    "def" : "3",
    "ghi" : "4",
    "jkl" : "5",
    "mno" : "6",
    "pqrs" : "7",
    "tuv" : "8",
    "wxyz" : "9"
]

class SequenceModel {
    var numSeq: String
    var capSeq: [Bool]
    
    init() {
        numSeq = ""
        capSeq = []
    }
    
    func isEmpty() -> Bool {
        return numSeq.isEmpty
    }
    
    func push(button: String, cap: Bool) {
        numSeq += buttonToNumber[button]!
        capSeq.append(cap)
    }
    
    func pop() {
        numSeq.remove(at: numSeq.index(before: numSeq.endIndex))
        print(numSeq)
        capSeq.removeLast()
    }
    
    func reset() {
        numSeq = ""
        capSeq = []
    }
    
    func addCapitalization(word: String) -> String {
        var chars = Array(word.characters)
        let range = 0...(capSeq.count-1)
        for i in range {
            if capSeq[i] {
                chars[i] = Character(String(chars[i]).uppercased())
            }
        }
        return String(chars)
    }
}
