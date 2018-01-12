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
        
        //if the username is incorrect display that as a message and shake the username field
        if(user.username != username)
        {
            FooterLabel.text = "Incorrect Username!"
            FooterLabel.textColor = .red
            incorrectInfo(fieldToShake: UserNameTextField)
        }
        else
        {
            //if the password is incorrect display that as a message and shake the password field
            if(user.password != password)
            {
                FooterLabel.text = "Incorrect Password!"
                FooterLabel.textColor = .red
                incorrectInfo(fieldToShake: PasswordTextField)
            }
            else
            {
                FooterLabel.text = "Don't share your login credentials"
                login(user: user)
            }
        }
        
    }
    
    func login(user: User)
    {
        //get the userdefaults so we can add key value pairs
        let defaults = UserDefaults.standard;
        
        //set the logged in user to the userdefaults
        defaults.set(user.username, forKey: "user")
        defaults.set(true, forKey: "loggedin")
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    func incorrectInfo(fieldToShake: UITextField)
    {
        //this will create a new animation object and whatever UITextField you send this method it will shake it
        let shakeAnim = CABasicAnimation(keyPath: "position")
        shakeAnim.duration = 0.1
        shakeAnim.repeatCount = 2
        shakeAnim.autoreverses = true
        shakeAnim.fromValue = NSValue(cgPoint: CGPoint(x: fieldToShake.center.x - 10, y: fieldToShake.center.y))
        shakeAnim.toValue = NSValue(cgPoint: CGPoint(x:fieldToShake.center.x + 10, y: fieldToShake.center.y))
        fieldToShake.layer.add(shakeAnim, forKey: "position")
    }

}

