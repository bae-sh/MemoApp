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
    @IBOutlet weak var shuffleButton: UIButton!
    
    let wordViewModel = WordViewModel()
    
    var wordsHiddenList: [Word] = []
    var meaningsHiddenList: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayer()
        wordViewModel.loadTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func setLayer(){
        editButton.layer.borderColor = UIColor.systemOrange.cgColor
        editButton.layer.borderWidth = 1.5
        editButton.layer.cornerRadius = 5
        
        shuffleButton.layer.borderColor = UIColor.systemOrange.cgColor
        shuffleButton.layer.borderWidth = 1.3
        shuffleButton.layer.cornerRadius = 5
        
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "show", sender: nil)
    }
    @IBAction func shuffleButtonTapped(_ sender: Any) {
        wordViewModel.shuffleWord()
        collectionView.reloadData()
    }
    @IBAction func wordsButtonTapped(_ sender: Any) {
        if wordsHiddenList.count == wordViewModel.words.count {// 단어 전부 가려져 있다면
            for var word in wordsHiddenList {
                word.wordIsSelected = false
                wordViewModel.updateWord(word)
            }
            wordsHiddenList.removeAll()
        }else{ // 전부 가리기
            for var word in wordViewModel.words {
                if !word.wordIsSelected {
                    word.wordIsSelected = true
                    wordsHiddenList.append(word)
                    wordViewModel.updateWord(word)
                }
            }
        }
        collectionView.reloadData()
    }
    @IBAction func meaningsButtonTapped(_ sender: Any) {
        if meaningsHiddenList.count == wordViewModel.words.count {// 단어 전부 가려져 있다면
            for var word in meaningsHiddenList {
                word.meaningIsSelected = false
                wordViewModel.updateWord(word)
            }
            meaningsHiddenList.removeAll()
        }else{ // 전부 가리기
            for var word in wordViewModel.words {
                if !word.meaningIsSelected {
                    word.meaningIsSelected = true
                    meaningsHiddenList.append(word)
                    wordViewModel.updateWord(word)
                }
            }
        }
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
        
        var word = wordViewModel.words[indexPath.item]
        cell.checkBoxTapHandler = { isSelected in
            word.isDone = isSelected
            self.wordViewModel.updateWord(word)
        }
        
        cell.wordMeaningButtonTapHandler = { what, isSelected in
            if(what == "word"){
                word.wordIsSelected = isSelected
            }else{
                word.meaningIsSelected = isSelected
            }
            self.wordViewModel.updateWord(word)
        }
        
        if word.wordIsSelected && !wordsHiddenList.contains(word) {
            wordsHiddenList.append(word)
        }
        if word.meaningIsSelected && !meaningsHiddenList.contains(word) {
           meaningsHiddenList.append(word)
        }
        
        cell.updateUIMemoVC(word: word)
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


