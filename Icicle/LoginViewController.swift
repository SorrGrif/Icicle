//
//  ViewController.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-08.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginButtonOnClick(_ sender: Any)
    {
        //when the login button is clicked, attempt to login with the given username and password
        
        
        //if the login is incorrect, prevent the user from gaining access
    }

}

