//
//  DictionaryModel.swift
//  Key9Pi
//
//  Created by Anna Hua on 2/14/17.
//  Copyright © 2017 EECS481. All rights reserved.
//

import Foundation

var alphaToNumeric: [String:Int] = [
    "a" : 2, "b" : 2, "c" : 2,
    "d" : 3, "e" : 3, "f" : 3,
    "g" : 4, "h" : 4, "i" : 4,
    "j" : 5, "k" : 5, "l" : 5,
    "m" : 6, "n" : 6, "o" : 6,
    "p" : 7, "q" : 7, "r" : 7, "s" : 7,
    "t" : 8, "u" : 8, "v" : 8,
    "w" : 9, "x" : 9, "y" : 9, "z" : 9
]

class Node {
    var wordList: [String:Int] = [:]
    var children: [Int:Node] = [:]
    var size: UInt64 = 0 //only for root node to track Trie size
}

class Trie {
    
    func insert(word: String, freq: Int, rootNode: Node) {
        //retain root node for incrementing size after insertion later
        var originalRootNode = rootNode
        var currNode = rootNode
        
        func traverseAddingNodes() -> Node {
            var keyNum = -1
            for letter in word.characters {
                keyNum = alphaToNumeric[String(letter)]!
                
                if currNode.children.index(forKey: keyNum) != nil {
                    currNode = currNode.children[keyNum]!
                } else {
                    keyNum = alphaToNumeric[String(letter)]!
                    currNode.children[keyNum] = Node()
                    currNode = currNode.children[keyNum]!
                }
            }

            return currNode
        }
        
        //TODO add frequency ordering for Beta
        func insertWordIntoList(nodeToAddWord: Node) {
            nodeToAddWord.wordList[word] = 0
            originalRootNode.size += 1
        }
        
        var nodeToAddWord = Node()
        nodeToAddWord = traverseAddingNodes()
        
        insertWordIntoList(nodeToAddWord: nodeToAddWord)
    }
    
    func getSize(rootNode: Node) -> UInt64 {
        return UInt64(rootNode.size);
    }
    
    func isEmpty(rootNode: Node) -> Bool {
        //print(rootNode.size)
        if UInt64(rootNode.size) == 0 {return true}
        
        return false;
    }
    
    func getPossibilities(seq: String, rootNode: Node) -> [String:Int] {
        var currNode = rootNode
        
        for number in seq.characters {
            let num = Int(String(number))
            if currNode.children.index(forKey: num!) != nil {
                currNode = currNode.children[num!]!
            } else {
                return [:]
            }
        }
        
        return currNode.wordList
    }
}






