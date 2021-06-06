//
//  TestViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/06/06.
//

import UIKit

class TestViewController: UIViewController {
    
    let wordViewModel = WordViewModel()
    var testCount: Int = 0
    @IBOutlet weak var testCountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func textTestCount(_ sender: Any) {
        testCount = Int(testCountTextField.text!) ?? 0
    }
    
}
