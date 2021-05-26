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
    var isDone: Bool
    
    mutating func update(word: String, meaning: String, isDone: Bool) {
        self.word = word
        self.meaning = meaning
        self.isDone = isDone
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
        return Word(id: nextId, word: "", meaning: "",isDone: false)
    }
    
    func addWord(_ word: Word) {
        words.append(word)
    }
    
    func updateWord(_ word: Word) {
        //TODO: updatee 로직 추가
        guard let index = words.firstIndex(of: word) else { return }
        words[index].update(word: word.word, meaning: word.meaning, isDone: word.isDone)
    }
    
    func deleteWord(_ deleteWords: [Word]) {
        for word in deleteWords {
            words = words.filter { $0.id != word.id }
        }
    }
    
    func shuffleWord(){
        words = words.shuffled()
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
    
    func deleteWord(_ words: [Word]) {
        manager.deleteWord(words)
    }
    
    func shuffleWord(){
        manager.shuffleWord()
    }
}
