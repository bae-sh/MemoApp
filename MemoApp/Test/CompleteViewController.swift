//
//  CompleteViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/06/09.
//

import UIKit

class CompleteViewController: UIViewController {
    @IBOutlet weak var isDone: UIButton!
    @IBOutlet weak var score: UILabel!
    
    var scoreText: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = scoreText
    }
    @IBAction func isDoneButtonTapped(_ sender: Any) {
        
    }
    
}
