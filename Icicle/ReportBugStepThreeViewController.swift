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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    @IBAction func prevStep()
    {
        performSegue(withIdentifier: "StepTwoSegue", sender: self)
    }
    
}
