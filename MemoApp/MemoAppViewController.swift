//
//  ViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/05/12.
//

import UIKit

class MemoAppViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

extension MemoAppViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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

extension MemoAppViewController: UICollectionViewDelegateFlowLayout { // flowlayout 과 차이점?
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
    
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var wordText: UITextField!
    @IBOutlet weak var meaningText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
