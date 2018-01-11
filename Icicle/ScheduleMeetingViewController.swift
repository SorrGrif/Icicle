//
//  ScheduleMeetingViewController.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-10.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//

import UIKit

class ScheduleMeetingViewController: UIViewController
{
    //MARK: Outlets
    @IBOutlet weak var FromDateButton: UIButton!
    @IBOutlet weak var FromTimeButton: UIButton!
    @IBOutlet weak var UntilDateButton: UIButton!
    @IBOutlet weak var UntilTimeButton: UIButton!
    @IBOutlet weak var DatePickerNavBar: UINavigationBar!
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    //MARK: Variables
    var currentButton: UIButton! = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //this block of code creates a date object to get the current
        //date and time
        //we format the date to get the name of the month
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        let month = formatter.string(from: date)
        formatter.dateFormat = "h:mm a"
        let time = formatter.string(from: date)
        
        //create a date and time string for fomatting purposes
        let dateString = "\(month) \(calendar.component(.day, from:date)), \(calendar.component(.year, from: date))";
        let timeString = time
        
        //not sure what the .normal does but it makes it not throw an error so meh.
        //set the title of the buttons to the current date and time
        FromDateButton.setTitle(dateString, for: .normal)
        FromTimeButton.setTitle(timeString, for: .normal)
        
        UntilDateButton.setTitle(dateString, for: .normal)
        UntilTimeButton.setTitle(timeString, for: .normal)
    }
    
    
    @IBAction func PickDate(_ sender: UIButton)
    {
        DatePickerNavBar.isHidden = false
        DatePicker.isHidden = false
        
        
        currentButton = sender
    }
    
    @IBAction func PickTime(_ sender: UIButton)
    {
        DatePickerNavBar.isHidden = false
        DatePicker.isHidden = false
        
        currentButton = sender
    }
    
    @IBAction func Done(_ sender: Any)
    {
        DatePickerNavBar.isHidden = true
        DatePicker.isHidden = true
        
        //
        
        
        currentButton.setTitle("", for: .normal)
    }
    
    @IBAction func Cancel(_ sender: Any)
    {
        DatePickerNavBar.isHidden = true
        DatePicker.isHidden = true
    }
}
