//
//  DictionaryModel.swift
//  Key9pi
//
//  Created by Michael on 3/7/17.
//  Copyright © 2017 EECS 481. All rights reserved.
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
    var wordList: [String:UInt64] = [:]
    var children: [Int:Node] = [:]
    var size: UInt64 = 0 //only for root node to track Trie size
}

class Trie {
    
    var rootNode = Node()
    var dict = [String:UInt64]()
    
    func loadTrie(fileName:String) {
        var common:UInt64 = 0
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            if let filepath = Bundle.main.path(forResource: "comm-dict", ofType: "txt")
            {
                do
                {
                    let contents = try String(contentsOfFile: filepath)
                    let lines = contents.components(separatedBy: "\n")
                    for line in lines {
                        print(line)
                        let trimmedLine = line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        self.insert(word: trimmedLine.lowercased(), freq: common, rootNode: self.rootNode)
                        common += 1
                    }
                }
                catch
                {
                    print("contents could not be loaded")
                }
            }
            else {
                print("Could not find file")
            }

            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                print(self.getSize(rootNode: self.rootNode))
            }
        }
    }
    
    func insert(word: String, freq: UInt64, rootNode: Node) {
        rootNode.size += 1
        var currNode = rootNode
        
        func traverseAddingNodes() -> Node {
            var keyNum = -1
            for letter in word.characters {
                if letter == "-" { continue }
                keyNum = alphaToNumeric[String(letter)]!
                
                if currNode.children.index(forKey: keyNum) != nil {
                    currNode = currNode.children[keyNum]!
                } else {
    
                    currNode.children[keyNum] = Node()
                    currNode = currNode.children[keyNum]!
                }
            }
            
            return currNode
        }
        
        //TODO add frequency ordering for Beta
        func insertWordIntoList(nodeToAddWord: Node) {
            nodeToAddWord.wordList[word] = freq
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
    
    func getPossibilities(seq: String, rootNode: Node, maxDepth: Int) -> [String:UInt64] {
        var currNode = rootNode
        
        for number in seq.characters {
            let num = Int(String(number))
            if currNode.children.index(forKey: num!) != nil {
                currNode = currNode.children[num!]!
            } else {
                return [:]
            }
        }
        
        var results = currNode.wordList
        
        func getDeeperPossibilities(startNode: Node, maxDepth: Int, count: Int) {
            if (startNode.children.count == 0 || count > maxDepth)  { return }
            
            for word in startNode.wordList {
                results[word.key] = word.value
            }
            
            for child in startNode.children {
                getDeeperPossibilities(startNode: child.value, maxDepth: maxDepth, count: count + 1)
            }
        }
        
        getDeeperPossibilities(startNode: currNode, maxDepth: 3, count: 0);
        
        return results
    }
}
