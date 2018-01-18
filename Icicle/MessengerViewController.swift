//
//  MessengerViewController.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-09.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//

import UIKit
import Foundation

class MessangerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    struct Message {
        var userid: Int
        var message: String
    }
    
    @IBAction func sendButton(_ sender: Any) {
        
        let message = messageInput.text!
        
        let url = URL(string: "http://icicle-messenger.portalcode.net/messages")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(User.jwt, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let postString = "body=\(message)"
        request.httpBody = postString.data(using: .utf8)
        let task2 = URLSession.shared.dataTask(with: request) { data, response, error in
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
            //DispatchQueue.main.async {
            //    //self.refreshChat()
            //}
            self.refreshChat()
            
            DispatchQueue.main.async {
                self.messageInput.text = ""
            }
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
//                
//                for i in 0 ..< json.count {
//                    print(json[i]["username"]!)
//                    self.usersArray.append(json[i]["username"]! as! String)
//                    
//                    
//                }
//                
//                //                DispatchQueue.main.async {
//                //                    self.messagesTableView.beginUpdates()
//                //
//                //                    //self.messagesTableView.dataSource = self
//                //                    for i in 0 ..< self.messagesArray.count {
//                //                        self.messagesTableView.insertRows(at: [NSIndexPath(item: i, section: 0) as IndexPath], with: .automatic)
//                //                    }
//                //                    self.messagesTableView.endUpdates()
//                //                }
//                
//                
//            } catch {
//                print("JSON DECODE ERROR")
//            }
        }
        task2.resume()
        
        
        
    }
    
    @IBOutlet weak var messageInput: UITextField!
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    var messagesArray: Array<Message> = []
    var usersArray: Array<String> = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        
        //let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, target: self, #selector(self.updateTime), userInfo)
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {_ in
            self.refreshChat()
        }
        
        let url = URL(string: "http://icicle-messenger.portalcode.net/users")!
        var request = URLRequest(url: url)
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(User.jwt, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //let postString = "email=\(username)&password=\(password)"
        //request.httpBody = postString.data(using: .utf8)
        let task2 = URLSession.shared.dataTask(with: request) { data, response, error in
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
                let json = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
                
                self.usersArray = []
                
                for i in 0 ..< json.count {
                    print(json[i]["username"]!)
                    self.usersArray.append(json[i]["username"]! as! String)
                }
                
                let url = URL(string: "http://icicle-messenger.portalcode.net/messages")!
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
                        let json = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
                        self.messagesArray = []
                        
                        for i in 0 ..< json.count {
                            print(json[i]["body"]!)
                            print(json[i]["created_by"]!)
                            
                            var userID: Int
                            if let num = (json[i]["created_by"] as? NSString)?.integerValue {
                                userID = num
                            } else {
                                userID = 1
                            }
                            //var userID = json[i]["created_by"] as! Int
                            
                            let body = json[i]["body"] as! String
                            
                            let message = Message(userid: userID, message: body)
                            //message.init()
                            self.messagesArray.append(message)
                            //                    self.messagesArray.append([json[i]["body"]! as! String,json[i]["created_by"] as! Int])
                            
                            
                        }
                        
                        //self.messagesTableView.dataSource = self
                        
                        
                        DispatchQueue.main.async {
                            self.messagesTableView.beginUpdates()
                            
                            //self.messagesTableView.reloadData()
                            //self.scrollToBottom()
                            for i in 0 ..< self.messagesArray.count {
                                self.messagesTableView.insertRows(at: [NSIndexPath(item: i, section: 0) as IndexPath], with: .automatic)
                            }
                            self.messagesTableView.endUpdates()
                            self.scrollToBottom()
                        }
                        
                        
                        
                        //                if let string = json as? [String: Any] {
                        //                        print(string)
                        //
                        //                } else {
                        //                        print("No Bueno")
                        //                }
                        
                    } catch {
                        print("JSON DECODE ERROR")
                    }
                }
                task.resume()
                
            } catch {
                print("JSON DECODE ERROR")
            }
        }
        task2.resume()
        
        //refreshChat()
    }
    
    func refreshChat() {
        
        
        let url = URL(string: "http://icicle-messenger.portalcode.net/messages")!
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
                let json = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
//                self.messagesArray = []
                self.messagesArray.removeAll()
                self.messagesTableView.reloadData()
                
                for i in 0 ..< json.count {
                    print(json[i]["body"]!)
                    print(json[i]["created_by"]!)
                    
                    var userID: Int
                    if let num = (json[i]["created_by"] as? NSString)?.integerValue {
                        userID = num
                    } else {
                        userID = 1
                    }
                    //var userID = json[i]["created_by"] as! Int
                    
                    let body = json[i]["body"] as! String
                    
                    let message = Message(userid: userID, message: body)
                    //message.init()
                    self.messagesArray.append(message)
                    //                    self.messagesArray.append([json[i]["body"]! as! String,json[i]["created_by"] as! Int])
                    
                    
                }
                
                //self.messagesTableView.dataSource = self
                
                
                DispatchQueue.main.async {
                    self.messagesTableView.beginUpdates()
                    
                    //self.messagesTableView.reloadData()
                    //self.scrollToBottom()
                    for i in 0 ..< self.messagesArray.count {
                        self.messagesTableView.insertRows(at: [NSIndexPath(item: i, section: 0) as IndexPath], with: .none)
                    }
                    self.messagesTableView.endUpdates()
                    self.scrollToBottom()
                }
                
                
                
                //                if let string = json as? [String: Any] {
                //                        print(string)
                //
                //                } else {
                //                        print("No Bueno")
                //                }
                
            } catch {
                print("JSON DECODE ERROR")
            }
        }
        task.resume()
        
        
        //messagesTableView.scrollRectToVisible(RectangleF(0, Ydisplacement, messagesTableView.Width, messagesTableView.Height), animated: true)
        //messagesTableView.scrollToRow(at: , at: UITableViewScrollPosition.top, animated: true)
    }
    
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        updateView()
//        
//        if shouldScrollTableToBottom {
//            scrollTableViewToBottom()
//        }
//        tableView.endUpdates() // Mark here no more updates to the tableview
//    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messagesArray.count-1, section: 0)
            self.messagesTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let messageUserID = self.messagesArray[indexPath.row].userid
        print(messageUserID)
        print(self.usersArray.count)
//        print("FUCK")
        
        cell.textLabel?.text = self.usersArray[messageUserID - 1]
        cell.detailTextLabel?.text = self.messagesArray[indexPath.row].message
//        cell.detailTextLabel?.preferredMaxLayoutWidth = messagesTableView.bounds.width
        return cell
    }
}
