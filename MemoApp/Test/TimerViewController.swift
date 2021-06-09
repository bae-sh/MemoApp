//
//  TimerViewController.swift
//  MemoApp
//
//  Created by 배성현 on 2021/06/07.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet weak var timeTextfield: UILabel!
    var myTimer : Timer?
    var number : Int = 3
    var testCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countStart()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "test" {
            let vc = segue.destination as? TestViewController
            vc?.testCount = testCount
        }
    }
    
    func countStart() {
        timeTextfield.text = String(number)
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    
    @objc func timerCallback() {
        number -= 1
        timeTextfield.text = String(number)
        if number == 0 {
            myTimer?.invalidate()
            performSegue(withIdentifier: "test", sender: nil)
        }
    }
}
