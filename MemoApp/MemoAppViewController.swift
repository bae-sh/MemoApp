//
//  ViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/12.
//

import UIKit

class MemoAppViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let wordViewModel = WordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func creatButtonTapped(_ sender: Any) {
        let word = WordManager.shared.creatWord()
        wordViewModel.addWord(word)
        collectionView.reloadData()
    }
}

extension MemoAppViewController: UICollectionViewDataSource { // 셀을 보여주기 위함
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordViewModel.words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: indexPath) as? WordCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView
        else {
            return UICollectionReusableView()
        }
        return header
    }
}

extension MemoAppViewController: UICollectionViewDelegateFlowLayout { // flowlayout 과 차이점? 셀의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
}

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var wordsTitle: UILabel!
    @IBOutlet weak var MeaningsTitle: UILabel!
    
    override func awakeFromNib() {//?
        super.awakeFromNib()
    }
}

class WordCell: UICollectionViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var wordText: UITextField!
    @IBOutlet weak var meaningText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func checkButtonTapped(_ sender: Any) {// 체크 버튼 활성화
        checkButton.isSelected = !checkButton.isSelected
        
    }
}

