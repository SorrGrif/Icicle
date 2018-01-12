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
    @IBOutlet weak var DatePickerNavBarTitle: UINavigationItem!
    
    //MARK: Variables
    var currentButton: UIButton! = nil
    var currentButtonType: ButtonType?
    let calendar = Calendar.current
    let formatter = DateFormatter()
    let monthFormat = "MMM DD, YYYY"
    let timeFormat = "h:mm a"
    
    //MARK: Enums
    enum ButtonType
    {
        case date
        case time
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //this block of code creates a date object to get the current
        //date and time
        //we format the date to get the name of the month
        let date = Date()
        
        formatter.dateFormat = monthFormat
        let month = formatter.string(from: date)
        formatter.dateFormat = timeFormat
        let time = formatter.string(from: date)
        
        //create a date and time string for fomatting purposes
        let dateString = month
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
        DatePickerNavBarTitle.title = "Pick Date"
        DatePicker.isHidden = false
        DatePicker.datePickerMode = .date
        
        
        currentButton = sender
        currentButtonType = .date
    }
    
    @IBAction func PickTime(_ sender: UIButton)
    {
        DatePickerNavBar.isHidden = false
        DatePickerNavBarTitle.title = "Pick Time"
        DatePicker.isHidden = false
        DatePicker.datePickerMode = .time
        
        currentButton = sender
        currentButtonType = .time
    }
    
    @IBAction func Done(_ sender: Any)
    {
        DatePickerNavBar.isHidden = true
        DatePicker.isHidden = true
        
        if(currentButtonType == .date)
        {
            formatter.dateFormat = monthFormat
            let month = formatter.string(from: DatePicker.date)
            
            currentButton.setTitle(month, for: .normal)
        }
        else if (currentButtonType == .time)
        {
            formatter.dateFormat = timeFormat
            let time = formatter.string(from: DatePicker.date)
            
            currentButton.setTitle(time, for: .normal)
        }
        
        
    }
    
    @IBAction func Cancel(_ sender: Any)
    {
        DatePickerNavBar.isHidden = true
        DatePicker.isHidden = true
    }
}
