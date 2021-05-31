//
//  ViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/13.
//

import UIKit

struct Word: Codable, Equatable {
    let id: Int
    var word: String
    var meaning: String
    var isDone: Bool
    var wordIsSelected: Bool
    var meaningIsSelected: Bool
    
    mutating func update(word: String, meaning: String, isDone: Bool,wordIsSelected: Bool,meaningIsSelected: Bool) {
        self.word = word
        self.meaning = meaning
        self.isDone = isDone
        self.wordIsSelected = wordIsSelected
        self.meaningIsSelected = meaningIsSelected
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
        return Word(id: nextId, word: "", meaning: "",isDone: false,wordIsSelected: false,meaningIsSelected: false)
    }
    
    func addWord(_ word: Word) {
        words.append(word)
        saveWord()
    }
    
    func updateWord(_ word: Word) {
        //TODO: updatee 로직 추가
        guard let index = words.firstIndex(of: word) else { return }
        words[index].update(word: word.word, meaning: word.meaning, isDone: word.isDone,wordIsSelected: word.wordIsSelected,meaningIsSelected: word.meaningIsSelected)
        saveWord()
    }
    
    func deleteWord(_ deleteWords: [Word]) {
        for word in deleteWords {
            words = words.filter { $0.id != word.id }
        }
        saveWord()
    }
    
    func shuffleWord(){
        words = words.shuffled()
        saveWord()
    }
    
    func saveWord(){
        Storage.store(words, to: .documents, as: "words.json")
    }
    
    func retrieveWord() {
        words = Storage.retrive("words.json", from: .documents, as: [Word].self) ?? []
        
        let lastId = words.last?.id ?? 0
        WordManager.lastId = lastId
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
    
    func loadTasks() {
        manager.retrieveWord()
    }
}
