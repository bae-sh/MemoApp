//
//  ViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/12.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var AllCheckButton: UIButton!
    @IBOutlet weak var collectionViewHeightConstraints: NSLayoutConstraint!
    
    let wordViewModel = WordViewModel()
    var willDeleteWords: [Word] = [] // 체크된 목록 리스트
    var keyboardIsShowing: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButton.layer.borderColor = UIColor.systemPink.cgColor // 완료 버튼 테두리
        clearButton.layer.borderWidth = 1.5
        clearButton.layer.cornerRadius = 5
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ noti: NSNotification){ // 키보드의 높이만큼 화면을 올려준다.
        if(!keyboardIsShowing){
            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                collectionViewHeightConstraints.constant -= keyboardHeight
            }
            keyboardIsShowing = true
        }
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification){ // 키보드의 높이만큼 화면을 내려준다.
        if(keyboardIsShowing){
            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                collectionViewHeightConstraints.constant += keyboardHeight
            }
            keyboardIsShowing = false;
        }
        
    }
    @IBAction func creatButtonTapped(_ sender: Any) {
        let word = WordManager.shared.creatWord()
        wordViewModel.addWord(word)
        collectionView.reloadData()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        wordViewModel.deleteWord(willDeleteWords)
        willDeleteWords = []
        AllCheckButton.isSelected = false
        collectionView.reloadData()
    }
    
    @IBAction func allCheckButtonTapped(_ sender: Any) {
        AllCheckButton.isSelected = !AllCheckButton.isSelected
        let selected = AllCheckButton.isSelected
        if(selected){
            willDeleteWords = wordViewModel.words
        }else{
            willDeleteWords = []
        }
        collectionView.reloadData()
    }
    
    @IBAction func dismissTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        dismiss(animated: true){
        }
    }
}

extension EditViewController: UICollectionViewDataSource { // 셀을 보여주기 위함
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordViewModel.words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: indexPath) as? WordCell else {
            return UICollectionViewCell()
        }
        
        var word = wordViewModel.words[indexPath.item]
        let selected = willDeleteWords.contains(word)
        cell.creatWordTapHandler = { text in
            word.word = text
            self.wordViewModel.updateWord(word)
        }
        
        cell.creatMeaningTapHandler = { text in
            word.meaning = text
            self.wordViewModel.updateWord(word)
        }
        cell.deleteCheckBoxTapHandler = { isSelected in
            if isSelected {
                self.willDeleteWords.append(word)
                if(self.willDeleteWords.count == self.wordViewModel.words.count){// 전부 체크했을때 allCheckbutton도 체크
                    self.AllCheckButton.isSelected = true
                }
            }else{
                self.willDeleteWords = self.willDeleteWords.filter { $0.id != word.id }
                self.AllCheckButton.isSelected = false
            }
            cell.deleteCheckButton.isSelected = isSelected
        }
        cell.updateUIEditVC(word: word, isSelected: selected)
        return cell
    }
    
}

extension EditViewController: UICollectionViewDelegateFlowLayout { // flowlayout 과 차이점? 셀의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
}
