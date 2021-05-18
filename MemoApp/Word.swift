//
//  ViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/13.
//

import UIKit

struct Word {
    let id: Int
    var word: String
    var meaning: String
}

class WordManager {
    static let shared = WordManager()
    static var lastId: Int = 0
    
    var words: [Word] = []
    
    func creatWord() -> Word {
        let nextId = WordManager.lastId + 1
        WordManager.lastId = nextId
        return Word(id: nextId, word: "", meaning: "")
    }
    
    func addWord(_ word: Word) {
        words.append(word)
        sortWord()
    }
    
    func sortWord() {
        words = words.sorted { prev, next in
            return prev.id < next.id
        }
    }
}

class WordViewModel {
    private let manager = WordManager.shared
    
    var words: [Word] {
        return manager.words
    }
    
    func addWord(_ word: Word) {
        manager.addWord(word)
    }
}
