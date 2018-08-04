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
class StatusMenuController: NSObject, PreferencesWindowDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var temporalView: TemporalView!
    
    var preferencesWindow: PreferencesWindow!
    
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    var timer = Timer()
    
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    
    var temporalMenuItem: NSMenuItem!
    
    @IBAction func preferencesClicked(_ sender: Any) {
        
        preferencesWindow.showWindow(nil)
    }
    
    
    
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
        
        temporalMenuItem = statusMenu.item(withTitle: "Temporal")
        temporalMenuItem.view = temporalView
        
        // Set timer format
        
        let timeFormat = defaults.string(forKey: "Time Format") ?? DEFAULT_TIME_FORMAT
        timeFormatter.dateFormat = timeFormat == "12h" ? "hh:mm:ss a": "HH:mm:ss"
        
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
        
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        
        
        let theme = defaults.string(forKey: "Theme") ?? DEFAULT_THEME
        self.temporalView.setTheme(theme: theme)
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
    
    func preferencesDidUpdate() {
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

}
