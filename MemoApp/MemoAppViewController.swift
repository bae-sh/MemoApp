//
//  ViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/12.
//

// viewmodel과 manager 싱글톤 탭 핸들러 무엇인지
// 싱글톤의경우 이 앱에서 사용하는 wordManager가 하나이므로 싱글톤을 사용해도 무관
// 뷰 모델에서는 뷰에 대한 정보를 가저옴
// 매니저는 워드에 해당하는 정보를 관리함
// Q)selector 은 무엇인가
import UIKit

class MemoAppViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editButton: UIButton!
    
    let wordViewModel = WordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.layer.borderColor = UIColor.orange.cgColor
        editButton.layer.borderWidth = 1.5
        editButton.layer.cornerRadius = 5
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    @IBAction func tapGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func creatButtonTapped(_ sender: Any) {
        let word = WordManager.shared.creatWord()
        wordViewModel.addWord(word)
        collectionView.reloadData()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "show", sender: nil)
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

extension MemoAppViewController: UICollectionViewDelegateFlowLayout { // flowlayout 과 차이점? 셀의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
}


