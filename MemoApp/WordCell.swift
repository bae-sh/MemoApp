//
//  WordCell.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/22.
//

import UIKit


class WordCell: UICollectionViewCell {
    @IBOutlet weak var wordText: UILabel!
    @IBOutlet weak var meaningText: UILabel!
    @IBOutlet weak var deleteCheckButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    var creatWordTapHandler: ((String) -> Void)?
    var creatMeaningTapHandler: ((String) -> Void)?
    var deleteCheckBoxTapHandler: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func checkButtonTapped(_ sender: Any) {
        checkButton.isSelected = !checkButton.isSelected
    }
    
    @IBAction func deleteCheckButtonTapped(_ sender: Any) {// 체크 버튼 활성화
        let isSelected = !deleteCheckButton.isSelected
        deleteCheckBoxTapHandler?(isSelected)
    }
    
    func updateUIMemoVC(word: Word) {
        wordText.text = word.word
        wordText.textColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if(wordText.text == ""){
            wordText.text = "Word..."
            wordText.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        meaningText.text = word.meaning
        meaningText.textColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if(meaningText.text == ""){
            meaningText.text = "Meaning..."
            meaningText.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    func updateUIEditVC(word: Word, isSelected: Bool) {
        wordText.text = word.word
        meaningText.text = word.meaning
        deleteCheckButton.isSelected = isSelected
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
