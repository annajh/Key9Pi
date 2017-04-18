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
    var wordList: [String:Int] = [:]
    var children: [Int:Node] = [:]
    var size: Int = 0 //only for root node to track Trie size
}

class Trie {
    
    var rootNode = Node()
   // var dict = [String:Int]()
    
    func loadTrie(fileName:String) {
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            if let filepath = Bundle.main.path(forResource: "comm-dict", ofType: "txt")
            {
                do
                {
                    let contents = try String(contentsOfFile: filepath)
                    let lines = contents.components(separatedBy: "\n")
                    for line in lines {
                        //print(line)
                        let trimmedLine = line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        self.insert(word: trimmedLine.lowercased(), freq: 0, rootNode: self.rootNode)
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
                if let userDefaults = UserDefaults(suiteName: "group.k9") {
                    let delWords = userDefaults.object(forKey: "delWords") as? [String] ?? [String]()
                    
                    for word in delWords {
                        trie.deleteWord(word: word, rootNode: trie.rootNode)
                    }
                }
                print(self.getSize(rootNode: self.rootNode))
            }
        }
    }
    
    func insert(word: String, freq: Int, rootNode: Node) {
        
        if wordInTrie(searchWord: word, rootNode: rootNode) { return }
        
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
        
        func insertWordIntoList(nodeToAddWord: Node) {
            nodeToAddWord.wordList[word] = freq
        }
        
        var nodeToAddWord = Node()
        nodeToAddWord = traverseAddingNodes()
        
        insertWordIntoList(nodeToAddWord: nodeToAddWord)
    }
    
    func deleteWord(word: String, rootNode: Node) {
        if wordInTrie(searchWord: word, rootNode: rootNode) {
            let deleteNode = self.findNode(word: word, rootNode: rootNode)
            
            for key in deleteNode.wordList.keys {
                if key == word {
                    deleteNode.wordList.removeValue(forKey: key)
                    return
                }
            }
        }
    }
    
    func incrementFreq(word: String, rootNode: Node) {
        let freqNode = self.findNode(word: word, rootNode: rootNode)
        
        for key in freqNode.wordList.keys {
            if key == word {
                freqNode.wordList[key] = (freqNode.wordList[key]! + 1)
            }
        }
    }
    
    func findNode(word: String, rootNode: Node) -> Node {
        var keyNum = -1
        var currNode = rootNode
        
        for letter in word.characters {
            if letter == "-" { continue }
            keyNum = alphaToNumeric[String(letter)]!
            
            if currNode.children.index(forKey: keyNum) != nil {
                currNode = currNode.children[keyNum]!
            }
        }
        
        return currNode
    }
    
    func getSize(rootNode: Node) -> Int {
        return Int(rootNode.size);
    }
    
    func isEmpty(rootNode: Node) -> Bool {
        //print(rootNode.size)
        if Int(rootNode.size) == 0 {return true}
        
        return false;
    }
    
    func getPossibilities(seq: String, rootNode: Node, maxDepth: Int) -> [String:Int] {
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
    
    func wordInTrie(searchWord: String, rootNode: Node) -> Bool {
        let searchNode = self.findNode(word: searchWord, rootNode: rootNode)
        
        for word in searchNode.wordList {
            if searchWord == word.key {
                return true
            }
        }
        
        return false
    }
}
