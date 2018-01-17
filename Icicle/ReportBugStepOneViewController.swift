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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func nextStep()
    {
        performSegue(withIdentifier: "StepTwoSegue", sender: self)
    }
    
    
}
