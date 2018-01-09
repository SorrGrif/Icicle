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
    @IBOutlet weak var FooterLabel: UILabel!
    
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
        let username = UserNameTextField.text!
        let password = PasswordTextField.text!
        
        let user = User(currentUser: username)
        
        FooterLabel.text = "Incorrect Username!"
        if(user.username == username)
        {
            FooterLabel.text = "Incorrect Password!"
            if(user.password == password)
            {
                FooterLabel.text = "Remember: Don't share you login credentials"
                login(user: user)
            }
        }
        
    }
    
    func login(user: User)
    {
        //get the userdefaults so we can add key value pairs
        let defaults = UserDefaults.standard;
        
        //set the logged in user to the userdefaults
        defaults.set(user, forKey: "user")
        defaults.set(true, forKey: "loggedin")
    }

}

