//
//  TestViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/06/08.
//

import UIKit

class TestViewController: UIViewController {
    var testWords: [Word] = []
    let wordViewModel = WordViewModel()
    var currentTestNumber = 1
    var testCount = 0
    var optionIndex = [0,1,2,3]
    
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
        setCurrentTestScore()
    }
    
    func setCurrentTestScore() {
        currentTestScore.text = "\(currentTestNumber)/\(testCount)"
    }
    func setTestWords() {
        testWords = wordViewModel.words.shuffled()
    }
    
    @IBAction func numberButtonTapped(_ sender: Any) {
        
        let button = sender as? UIButton
        let meaning = button?.titleLabel?.text
        
    }
    
    func checkCorrect(meaning: String) {
    }
}
