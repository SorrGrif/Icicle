//
//  ReportBugStepThreeViewController.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-17.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//

import UIKit

class ReportBugStepThreeViewController: UIViewController
{
    
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var IssueDescriptionTextField: UITextView!
    @IBOutlet weak var RecreateIssueTextField: UITextView!
    //get the defaults for persistent data
    let defaults = UserDefaults.standard;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        IssueDescriptionTextField.text = defaults.value(forKey: "issuedescription") as! String
        RecreateIssueTextField.text = defaults.value(forKey: "recreateissue") as! String
    }
    
    
    @IBAction func prevStep()
    {
        performSegue(withIdentifier: "StepTwoSegue", sender: self)
    }
    
    @IBAction func Submit(_ sender: Any)
    {
        defaults.set("I was doing...", forKey: "issuedescription")
        defaults.set("If you...", forKey: "recreateissue")
        
        SubmitButton.setTitle("Bug Submitted!", for: .disabled)
        SubmitButton.isEnabled = false
    }
}
