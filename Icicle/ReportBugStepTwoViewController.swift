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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func nextStep()
    {
        performSegue(withIdentifier: "StepThreeSegue", sender: self)
    }
    
    @IBAction func prevStep()
    {
        performSegue(withIdentifier: "StepOneSegue", sender: self)
    }
    
}
