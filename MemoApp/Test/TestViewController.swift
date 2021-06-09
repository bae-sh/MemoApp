//
//  TestViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/06/08.
//

import UIKit

class TestViewController: UIViewController {
    var words: [Word] = []
    var testWords: [Word] = []
    var questionWords: [Word] = []
    let wordViewModel = WordViewModel()
    
    
    var currentTestNumber = 1
    var testCount = 0
    var optionIndex = [0,1,2,3]
    var score = 0
    
    @IBOutlet weak var questionWord: UILabel!
    @IBOutlet weak var numberFourButton: UIButton!
    @IBOutlet weak var numberThreeButton: UIButton!
    @IBOutlet weak var numberTwoButton: UIButton!
    @IBOutlet weak var numberOneButton: UIButton!
    
    @IBOutlet weak var currentTestScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTestWords()
    }
    override func viewWillAppear(_ animated: Bool) {
        if currentTestNumber > testCount {
            return
        }
        setCurrentTestScore()
        setQuestion()
    }
    
    func setCurrentTestScore() {
        currentTestScore.text = "\(currentTestNumber)/\(testCount)"
    }
    
    func setQuestion() {
        wordShuffle()
        questionWord.text = testWords[currentTestNumber - 1].word
        numberOneButton.setTitle(questionWords[optionIndex[0]].meaning, for: .normal)
        numberTwoButton.setTitle(questionWords[optionIndex[1]].meaning, for: .normal)
        numberThreeButton.setTitle(questionWords[optionIndex[2]].meaning, for: .normal)
        numberFourButton.setTitle(questionWords[optionIndex[3]].meaning, for: .normal)
    }
    
    func wordShuffle() {
        questionWords.removeAll()
        words = words.shuffled()
        optionIndex = optionIndex.shuffled()
        
        let curQuestionWord = testWords[currentTestNumber - 1]
        questionWords.append(curQuestionWord)
        
        for word in words {
            if word != curQuestionWord {
                questionWords.append(word)
            }
            if questionWords.count == 4 {
                break
            }
        }
    }
    func setTestWords() {
        words = wordViewModel.words.shuffled()
        
        for i in 0..<testCount {
            testWords.append(words[i])
        }
        currentTestNumber = 1
        score = 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "complete" {
            let vc = segue.destination as? CompleteViewController
            vc?.scoreText = "정답: \(score) / \(testCount)"
        }
    }
    @IBAction func numberButtonTapped(_ sender: Any) {
        
        let button = sender as? UIButton
        let meaning = button?.titleLabel?.text
        checkCorrect(meaning: meaning!)
        currentTestNumber += 1
        if currentTestNumber > testCount {
            performSegue(withIdentifier: "complete", sender: nil)
        }else {
            viewWillAppear(false)
        }
    }
    
    func checkCorrect(meaning: String) {
        let curQuestionWord = testWords[currentTestNumber - 1]
        if curQuestionWord.meaning == meaning {
            score += 1
        }
    }
}
