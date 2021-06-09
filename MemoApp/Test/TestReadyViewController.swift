//
//  TestViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/06/06.
//

import UIKit

class TestReadyViewController: UIViewController {
    
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
    @IBAction func startButtonTapped(_ sender: Any) {
        if testCount > wordViewModel.words.count || testCount == 0 {
            showAlert()
        } else {
            performSegue(withIdentifier: "timer", sender: nil)
        }
    }
    
    @IBAction func unwindReadyVC (segue : UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timer" {
            let vc = segue.destination as? TimerViewController
            vc?.testCount = testCount
        }
    }
    func showAlert() {
        let message = "테스트의 수는 1 이상 \(wordViewModel.words.count) 이하의 값이어야 합니다."
        
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


