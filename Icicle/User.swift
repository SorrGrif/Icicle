//
//  User.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-09.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//

import Foundation
import CoreData

class User
{
    //MARK: User Details
    var username = "N/A"
    var password = "N/A"
    var name = "N/A"
    var company = "N/A"
    var position = "N/A"
    var salary = "N/A"
    
    //MARK: Users List
    var userList: [String : [String: String]]?
    
    init(currentUser: String)
    {
        //this will retrieve the list of users from the server
        
        //currently hardcoded
        getUserList()
        
        //this will get the user data of the current user
        getUserData(currentUser: currentUser)
    }
    
    func getUserList()
    {
        //pull the userlist from the server
        
        //userlist is formated as a 2d dictionary within a 1d dictionary
        //login : [field:value]
        
        //hard coded for now
        userList =
            [
                "sorrgrif" :
                    [
                        "username":"sorrgrif",
                        "password":"griffin1",
                        "name":"Griffin Sorrentino",
                        "company":"FakeComp co.",
                        "position":"Mobile App Dev",
                        "salary":"20000",
                    ],
                "itbrown" :
                    [
                        "username":"itbrown",
                        "password":"aperture",
                        "name":"Brandon \"I.T.\" Brown",
                        "company":"FakeComp co.",
                        "position":"Back-End Developer",
                        "salary":"75000",
                    ]
            ]

    }
    
    func getUserData(currentUser: String)
    {
        //this whole section will be changed with getting data from the server but in the mean time it will be hard coded
       
        //for each user in the userlist check if the user exists
        for user in userList!
        {
            //if the user exists populate each field with the respective values
            if currentUser == user.key
            {
                username = user.value["username"]!
                password = user.value["password"]!
                name = user.value["name"]!
                company = user.value["company"]!
                position = user.value["position"]!
                salary = user.value["salary"]!
            }
        }
    
    }
    
    
}
