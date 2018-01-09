//
//  ProfileViewController.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-08.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var ProfileNameLabel: UILabel!
    @IBOutlet weak var CompanyLabel: UILabel!
    @IBOutlet weak var PositionLabel: UILabel!
    @IBOutlet weak var SalaryLabel: UILabel!

    //MARK: Objects
    var user: User?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        //Init the user object with the current user and gather the current users information
        user = User(currentUser: defaults.value(forKey: "user") as! String)
        
        //populate the labels with the users information
        ProfileNameLabel.text = user!.name
        CompanyLabel.text = user!.company
        PositionLabel.text = user!.position
        SalaryLabel.text = "$\(user!.salary)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogOutButtonOnClick(_ sender: Any)
    {
        //reset the userdefaults
        let defaults = UserDefaults.standard
        
        defaults.set("", forKey: "user")
        defaults.set(false, forKey: "loggedin")
    }
    
}
