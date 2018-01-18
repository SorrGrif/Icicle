//
//  ScheduleMeetingViewController.swift
//  Icicle
//
//  Created by Griffin Sorrentino on 2018-01-10.
//  Copyright © 2018 Griffin Sorrentino. All rights reserved.
//

import UIKit
import UserNotifications

class ScheduleMeetingViewController: UIViewController, UNUserNotificationCenterDelegate
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
    
    //MARK: Variables
    var isAccessGranted = false
    var notificationYear: Int?
    var notificationMonth: Int?
    var notificationDay: Int?
    var notificationHour: Int?
    var notificationMinute: Int?
    var notificationSecond: Int?
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //get access to the notifcations on the phone
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge],
                                    completionHandler: { granted, error in self.isAccessGranted = granted })
        
        center.delegate = self
        
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
        DatePicker.datePickerMode = .time
        
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
            
            //I will come back to this area of code and insert code to make a notification at the set from date
            formatter.dateFormat = "YYYY"
            notificationYear = Int(formatter.string(from: DatePicker.date))
            
            formatter.dateFormat = "MM"
            notificationMonth = Int(formatter.string(from: DatePicker.date))
            
            formatter.dateFormat = "DD"
            notificationDay = Int(formatter.string(from: DatePicker.date))

        }
        //if the current button type is time, format the string for a time
        else if (currentButtonType == .time)
        {
            formatter.dateFormat = timeFormat
            let time = formatter.string(from: DatePicker.date)
            
            //set the title of the button to the time that was selected
            currentButton.setTitle(time, for: .normal)
            
            formatter.dateFormat = "HH"
            notificationHour = Int(formatter.string(from: DatePicker.date))
            
            formatter.dateFormat = "mm"
            notificationMinute = Int(formatter.string(from: DatePicker.date))
            
            formatter.dateFormat = "ss"
            notificationSecond = Int(formatter.string(from: DatePicker.date))
        }
        
    }
    
    @IBAction func Cancel(_ sender: Any)
    {
        //if the cancel button was pressed simply make the datepicker invisible
        DatePickerNavBar.isHidden = true
        DatePicker.isHidden = true
    }
    
    func addNotification(trigger: UNNotificationTrigger, content: UNMutableNotificationContent, identifier: String)
    {
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in if error != nil{
            print("error adding notification")
            
            }
        })
    }
    
    @IBAction func scheduleNotification()
    {
        //set the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Scheduled Meeting"
        content.body = "You have a meeting in 5 minutes"
        content.sound = UNNotificationSound.default()
        
        let calendarComponents:Set<Calendar.Component> = [.hour, .minute, .second, .month, .day, .year]
        
        var date = Calendar.current.dateComponents(calendarComponents, from: Date())
        date.year = notificationYear!
        date.month = notificationMonth!
        date.day = notificationDay!
        date.hour = notificationHour!
        date.minute = notificationMinute! - 5
        date.second = notificationSecond!
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        addNotification(trigger: trigger, content: content, identifier: "notification.timer")
    }
}
