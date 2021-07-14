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
    var correctAnswer = 0
    var questionsAsked = 0
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .done, target: self, action: #selector(showScoreOnTap))
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
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        /*CALayer (core animation layer) is lower than UIbutton so doesn't know
          what UIcolor is, so we call a UIcolor light gray, then so it matches
          the type, we converted it to CGColor. */
        askQuestion()
        
        
        // Do any additional setup after loading the view.
    }
    //UIAlertAction is required for the alert we do after tapping, in which one of the parameters needs a method that accepts this type as a parameter
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        if questionsAsked == 10{
            questionsAsked = 0
            score = 0
        } 
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased())"
        questionsAsked += 1
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        }
        else{
            title = "Wrong, that's the flag of \(countries[sender.tag]) "
            score += 0
        }
        if questionsAsked != 10 {
        let ac = UIAlertController(title: title, message: "Your Score is \(score).", preferredStyle: .alert)
        //can use .alert or .actionsheet. alert is for showing people changes, latter is for showing a list of options.
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion)) //if we use askQuestion() it is telling the compiler "run this now, and IT will tell you the name of the method to run.
        present(ac, animated: true)
        }
        
        if questionsAsked == 10{
            let ac = UIAlertController(title: title, message: "Your Score is \(score) out of 10.", preferredStyle: .alert)
            
            //can use .alert or .actionsheet. alert is for showing people changes, latter is for showing a list of options.
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion)) //if we use askQuestion() it is telling the compiler "run this now, and IT will tell you the name of the method to run.
            present(ac, animated: true)
        }
    }
    @objc func showScoreOnTap() {
        let currentScore = score
        
        let vc = UIAlertController(title: "Current Score", message: " \(currentScore)", preferredStyle: .alert)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        vc.addAction(UIAlertAction(title: "Keep Playing", style: .cancel, handler: {action in}))
        present(vc, animated: true)
    }
    

}

