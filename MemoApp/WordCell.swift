//
//  WordCell.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/22.
//

import UIKit


class WordCell: UICollectionViewCell {
    @IBOutlet weak var wordText: UITextField!
    @IBOutlet weak var meaningText: UITextField!
    @IBOutlet weak var deleteCheckButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var wordButton: UIButton!
    @IBOutlet weak var meanButton: UIButton!
    
    var creatWordTapHandler: ((String) -> Void)?
    var creatMeaningTapHandler: ((String) -> Void)?
    var deleteCheckBoxTapHandler: ((Bool) -> Void)?
    var checkBoxTapHandler: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func checkButtonTapped(_ sender: Any) {
        checkButton.isSelected = !checkButton.isSelected
        checkBoxTapHandler?(checkButton.isSelected)
    }
    @IBAction func wordButtonTapped(_ sender: Any) {
        wordButton.isSelected = !wordButton.isSelected
        if(wordButton.backgroundColor == nil){
            wordButton.backgroundColor = .systemOrange
        }else{
            wordButton.backgroundColor = nil
        }
    }
    @IBAction func meaningButtonTapped(_ sender: Any) {
        meanButton.isSelected = !meanButton.isSelected
        if(meanButton.backgroundColor == nil){
            meanButton.backgroundColor = .systemOrange
        }else{
            meanButton.backgroundColor = nil
        }
    }
    
    @IBAction func deleteCheckButtonTapped(_ sender: Any) {// 체크 버튼 활성화
        let isSelected = !deleteCheckButton.isSelected
        deleteCheckBoxTapHandler?(isSelected)
    }
    
    func updateUIMemoVC(word: Word) {
        updateButton(word: word,button: wordButton)
        updateButton(word: word,button: meanButton)
        checkButton.isSelected = word.isDone
    }
    
    func updateUIEditVC(word: Word, isSelected: Bool) {
        wordText.text = word.word
        meaningText.text = word.meaning
        deleteCheckButton.isSelected = isSelected
    }
    
    func updateButton(word: Word, button: UIButton!){
        if(button==wordButton){
            button.setTitle(word.word, for: .normal)
        }else{
            button.setTitle(word.meaning, for: .normal)
        }
        
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.systemOrange.cgColor
        
        if(button.currentTitle == ""){
            let blank: String
            if(button==wordButton){
                blank = "Word..."
            }else{
                blank = "Meaning.."
            }
            button.setTitle("\(blank)", for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
        }
        
    }
    @IBAction func creatWord(_ sender: Any) {
        let text = wordText.text ?? ""
        creatWordTapHandler?(text)
    }
    
    @IBAction func creatMeaning(_ sender: Any) {
        let text = meaningText.text ?? ""
        creatMeaningTapHandler?(text)
    }
}
