//
//  StatusMenuController.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 7/22/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

let DEFAULT_THEME = "Night"
let DEFAULT_TIME_FORMAT = "12h"

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var timeString: String
}
class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var temporalView: TemporalView!
    @IBOutlet weak var timeFormat12h: NSMenuItem!
    @IBOutlet weak var timeFormat24h: NSMenuItem!
    @IBOutlet weak var themeMenu: NSMenuItem!
    
    
    var preferencesWindow: PreferencesWindow!
    
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    var timer = Timer()
    
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    
    var temporalMenuItem: NSMenuItem!
    
    
    @IBAction func quitClicked(_ sender: Any) {
        
        NSApplication.shared.terminate(self)
    }
    
    override func awakeFromNib()
    {
        
        let defaults = UserDefaults.standard
        let icon = NSImage(named: "Temporal-Icon")
        // icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        temporalMenuItem = statusMenu.item(withTitle: "TemporalView")
        temporalMenuItem.view = temporalView
        
        // Set timer format
        
        let timeFormat = defaults.string(forKey: "Time Format") ?? DEFAULT_TIME_FORMAT
        timeFormatter.dateFormat = timeFormat == "12h" ? "hh:mm:ss a": "HH:mm:ss"
        
        timeFormat12h.state = timeFormat == "12h" ? .on : .off
        timeFormat24h.state = timeFormat == "24h" ? .on : .off
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        showTime()
        
        // Negative value of timeInterval causes the timer to default to 0.1 ms
        timer = Timer.scheduledTimer(timeInterval: -1,
                                     target: self,
                                     selector: #selector(showTime),
                                     userInfo: nil,
                                     repeats: true)
        
        // add timer to RunLoop for handling during event loops
        RunLoop.current.add(timer, forMode: RunLoop.Mode.eventTracking)
        
        
        let theme = defaults.string(forKey: "Theme") ?? DEFAULT_THEME
        self.temporalView.setTheme(theme: theme)
        
        for themeName in CalendarView.calendarThemeColors.keys
        {
            self.themeMenu.submenu!.addItem(withTitle: themeName, action: #selector(themeChanged), keyEquivalent: "").target = self
           
        }
        
        for item in self.themeMenu.submenu!.items
        {
            if item.title == theme
            {
                item.state = .on
            }
            else
            {
                item.state = .off
            }
        }
        
        
    }
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }
    
    @objc func showTime()
    {
        
        let date = Date()
        
        let calendar = Calendar.current
        
        let currentTime = timeFormatter.string(from: date)
      
        
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        let seconds = calendar.component(.second, from: date)
        
        temporalView.setTime(time: Time(hours: hours, minutes: minutes, seconds: seconds, timeString: currentTime))
        
        updateWindow()
        
        
    }
    
    func updateWindow()
    {
        let defaults = UserDefaults.standard
        let theme = defaults.string(forKey: "Theme") ?? DEFAULT_THEME
        self.temporalView.setTheme(theme: theme)
        
        let timeFormat = defaults.string(forKey: "Time Format") ?? DEFAULT_TIME_FORMAT
        timeFormatter.dateFormat = timeFormat == "12h" ? "hh:mm:ss a": "HH:mm:ss"
    }
    
    // Actions
    
    @objc func themeChanged(_ sender: AnyObject)
    {
        let sendingMenu = sender as! NSMenuItem
        
        let themeName = sendingMenu.title
        
        let defaults = UserDefaults.standard
        defaults.setValue(themeName, forKey: "Theme")
        
        for item in self.themeMenu.submenu!.items
        {
            if item.title == themeName
            {
                item.state = .on
            }
            else
            {
                item.state = .off
            }
        }
    }
    @IBAction func timeFormatChanged(_ sender: AnyObject)
    {
        let sendingMenu = sender as! NSMenuItem
        let timeFormatStyle: String
        
        if sendingMenu.title == "12 hour"
        {
            timeFormatStyle = "12h"
            self.timeFormat12h.state = .on
            self.timeFormat24h.state = .off
        }
        else
        {
            timeFormatStyle = "24h"
            self.timeFormat12h.state = .off
            self.timeFormat24h.state = .on
        }
        let defaults = UserDefaults.standard
        defaults.setValue(timeFormatStyle, forKey: "Time Format")
        
        
    }

}
