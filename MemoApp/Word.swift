//
//  ViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/13.
//

import UIKit

struct Word: Equatable {
    let id: Int
    var word: String
    var meaning: String
    
    mutating func update(word: String, meaning: String) {
        self.word = word
        self.meaning = meaning
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        // TODO: 동등 조건 추가
        return lhs.id == rhs.id
    }
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
    }
    
    func updateWord(_ word: Word) {
        //TODO: updatee 로직 추가
        guard let index = words.firstIndex(of: word) else { return }
        words[index].update(word: word.word, meaning: word.meaning)
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
    
    func updateWord(_ word: Word) {
        manager.updateWord(word)
    }
}
