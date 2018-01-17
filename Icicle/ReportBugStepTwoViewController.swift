//
//  ReportBugStepTwoViewController.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-17.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//


import UIKit

class ReportBugStepTwoViewController: UIViewController
{
    
    @IBOutlet weak var RecreateIssueTextField: UITextView!
     let defaults = UserDefaults.standard;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //get the defaults for persistent data
        RecreateIssueTextField.text = defaults.value(forKey: "recreateissue") as! String

    }
    
    @IBAction func nextStep()
    {
        //set the description of the recreating to the recreateissue key
        defaults.set(RecreateIssueTextField.text, forKey: "recreateissue")

        performSegue(withIdentifier: "StepThreeSegue", sender: self)
    }
    
    @IBAction func prevStep()
    {
        
        performSegue(withIdentifier: "StepOneSegue", sender: self)
    }
    
    @IBAction func dismissKeyboard()
    {
        self.view.endEditing(true)
    }

    
    
}
