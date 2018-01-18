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
        
        let url = URL(string: "http://icicle-messenger.portalcode.net/authenticate")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "email=\(username)&password=\(password)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            do {
                let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                print("\(json["auth_token"] as? String)")
                if let token = json["auth_token"] as? String {
                    User.jwt = token
                    print(token)
                    let user = User(currentUser: username)
                    DispatchQueue.main.async {
                        self.FooterLabel.text = "Don't share your login credentials"
                        self.login(user: user, viewController: self)
                    }
                } else {
                    print("LOGIN FAILURE")
                    DispatchQueue.main.async {
                        self.incorrectInfo(fieldToShake: self.UserNameTextField)
                        self.FooterLabel.text = "Incorrect Username or Password!"
                        self.FooterLabel.textColor = .red
                        self.incorrectInfo(fieldToShake: self.PasswordTextField)
                    }
                }
                
            } catch {
                print("JSON DECODE ERROR")
            }
        }
        task.resume()
    }
    
    func login(user: User, viewController: UIViewController)
    {
        //get the userdefaults so we can add key value pairs
        let defaults = UserDefaults.standard;
        
        let url = URL(string: "http://icicle-messenger.portalcode.net/currentuser")!
        var request = URLRequest(url: url)
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(User.jwt, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //let postString = "email=\(username)&password=\(password)"
        //request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            do {
                let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                print("\(json["username"] as? String)")
                if let username = json["username"] as? String {
                    let user = User(currentUser: username)
                    if let company = json["company"] as? String {
                        user.company = company
                    } else {
                        user.company = "N/A:"
                    }
                    
                    if let position = json["position"] as? String {
                        user.position = position
                    } else {
                        user.position = "N/A:"
                    }
                    
                    if let salary = json["salary"] as? String {
                        user.salary = salary
                    } else {
                        user.salary = "N/A:"
                    }
                    
                    user.username = username
                    
                    ProfileViewController.user = user	
//                    DispatchQueue.main.async {
//                        self.FooterLabel.text = "Don't share your login credentials"
//                        self.login(user: user)
//                        
//                        //set the logged in user to the userdefaults
//                        defaults.set(user.username, forKey: "user")
//                        defaults.set(true, forKey: "loggedin")
//             	       }
                    DispatchQueue.main.async {
                        viewController.performSegue(withIdentifier: "LoginSegue", sender: self)
                    }
                    
                } else {
                    print("LOGIN FAILURE")
                    DispatchQueue.main.async {
                        self.incorrectInfo(fieldToShake: self.UserNameTextField)
                        self.FooterLabel.text = "Incorrect Username or Password!"
                        self.FooterLabel.textColor = .red
                        self.incorrectInfo(fieldToShake: self.PasswordTextField)
                    }
                }
                
            } catch {
                print("JSON DECODE ERROR")
            }
        }
        task.resume()
        
        
        
        //performSegue(withIdentifier: "LoginSegue", sender: self)
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
    
    @IBAction func dismissKeyboard()
    {
        self.view.endEditing(true)
    }

}

