//
//  ViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/12.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editButton: UIButton!
    
    let wordViewModel = WordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.layer.borderColor = UIColor.orange.cgColor
        editButton.layer.borderWidth = 1.5
        editButton.layer.cornerRadius = 5
    }
    
    @IBAction func tapGesture(_ sender: Any) {//빈 화면 클릭시 키보드 내림
       self.view.endEditing(true)
    }
    
    @IBAction func creatButtonTapped(_ sender: Any) {
        let word = WordManager.shared.creatWord()
        wordViewModel.addWord(word)
        collectionView.reloadData()
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
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
        cell.creatWordTapHandler = { text in
            word.word = text
            self.wordViewModel.updateWord(word)
            collectionView.reloadData()
        }
        
        cell.creatMeaningTapHandler = { text in
            word.meaning = text
            self.wordViewModel.updateWord(word)
            collectionView.reloadData()
        }
        cell.updateUI(word: word)
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
