//
//  DictionaryModel.swift
//  Key9Pi
//
//  Created by Anna Hua on 2/14/17.
//  Copyright © 2017 EECS481. All rights reserved.
//

import Foundation

var alphaToNumeric: [String:Int] = [
    "a" : 1, "b" : 1, "c" : 1,
    "d" : 2, "e" : 2, "f" : 2,
    "g" : 3, "h" : 3, "i" : 3,
    "j" : 4, "k" : 4, "l" : 4,
    "m" : 5, "n" : 5, "o" : 5,
    "p" : 6, "q" : 6, "r" : 6,
    "s" : 7, "t" : 7, "u" : 7,
    "v" : 8, "w" : 8, "x" : 8,
    "y" : 9, "z" : 9
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






