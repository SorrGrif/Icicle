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
        
        //not sure what the .normal does but it makes it not throw an error so meh.
        //set the title of the buttons to the current date and time
        FromDateButton.setTitle(month, for: .normal)
        FromTimeButton.setTitle(time, for: .normal)
        
        UntilDateButton.setTitle(month, for: .normal)
        UntilTimeButton.setTitle(time, for: .normal)
    }
    
    
    @IBAction func PickDate(_ sender: UIButton)
    {
        //if a date button is pressed make the datepicker visible
        DatePickerNavBar.isHidden = false
        DatePicker.isHidden = false
        
        //set the title to pick date and the mode to a date
        DatePickerNavBarTitle.title = "Pick Date"
        DatePicker.datePickerMode = .date
        
        //set the current button to the one that was tapped
        currentButton = sender
        
        //and the button type of an enum of type date
        currentButtonType = .date
    }
    
    @IBAction func PickTime(_ sender: UIButton)
    {
        //if a time button is pressed make the datepicker visible
        DatePickerNavBar.isHidden = false
        DatePicker.isHidden = false
        
        //set the title to pick time and the mode to a time
        DatePickerNavBarTitle.title = "Pick Time"
        DatePicker.datePickerMode = .date
        
        //set the current button to the one that was tapped
        currentButton = sender
        
        //and the button type of an enum of type time
        currentButtonType = .time
    }
    
    @IBAction func Done(_ sender: Any)
    {
        //if the done button was pressed hide the datepicker view
        DatePickerNavBar.isHidden = true
        DatePicker.isHidden = true
        
        //if the current button type is date, format the string for a date
        if(currentButtonType == .date)
        {
            formatter.dateFormat = monthFormat
            let date = formatter.string(from: DatePicker.date)
            
            //set the title of the button to the date that was selected
            currentButton.setTitle(date, for: .normal)
        }
        //if the current button type is time, format the string for a time
        else if (currentButtonType == .time)
        {
            formatter.dateFormat = timeFormat
            let time = formatter.string(from: DatePicker.date)
            
            //set the title of the button to the time that was selected
            currentButton.setTitle(time, for: .normal)
        }
        
        
        //I will come back to this area of code and insert code to make a notification at the set from date
        //HERE
        //HERE
        //HERE
        //HERE
        //HERE
        //HERE
        //HERE
        //HERE
        //HERE
        //HERE
        
        
    }
    
    @IBAction func Cancel(_ sender: Any)
    {
        //if the cancel button was pressed simply make the datepicker invisible
        DatePickerNavBar.isHidden = true
        DatePicker.isHidden = true
    }
}
