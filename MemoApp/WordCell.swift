//
//  WordCell.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/22.
//

import UIKit


class WordCell: UICollectionViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var wordText: UITextField!
    @IBOutlet weak var meaningText: UITextField!
    
    var creatWordTapHandler: ((String) -> Void)?
    var creatMeaningTapHandler: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func checkButtonTapped(_ sender: Any) {// 체크 버튼 활성화
        checkButton.isSelected = !checkButton.isSelected
        
    }
    func updateUI(word: Word) {
        wordText.text = word.word
        meaningText.text = word.meaning
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
