//
//  ReportBugStepOneViewController.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-17.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//

import UIKit

class ReportBugStepOneViewController: UIViewController
{
    
    @IBOutlet weak var IssueDescriptionTextField: UITextView!
    let defaults = UserDefaults.standard;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        IssueDescriptionTextField.text = defaults.value(forKey: "issuedescription") as! String
    }

    @IBAction func nextStep()
    {
        
        //set the description of the issue to the issuedescription key
        defaults.set(IssueDescriptionTextField.text, forKey: "issuedescription")

        performSegue(withIdentifier: "StepTwoSegue", sender: self)
    }
    
    
}
