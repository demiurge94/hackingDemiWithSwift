//
//  ViewController.swift
//  project2
//
//  Created by Erick Vicencio on 6/30/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        countries.append("Estonia")
        countries.append("France")
        countries.append("Germany")
        countries.append("Ireland")
        countries.append("Italy")
        countries.append("Monaco")
        countries.append("Nigeria")
        countries.append("Poland")
        countries.append("Russia")
        countries.append("Spain")
        countries.append("UK")
        countries.append("US")
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        askQuestion()
        // Do any additional setup after loading the view.
    }
    func askQuestion(){
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }


}

