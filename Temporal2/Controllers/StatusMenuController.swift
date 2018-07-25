//
//  StatusMenuController.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 7/22/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var timeString: String
}
class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var temporalView: TemporalView!
    
    var timer = Timer()
    
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    
    var temporalMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    @IBAction func quitClicked(_ sender: Any) {
        
        NSApplication.shared.terminate(self)
    }
    
    override func awakeFromNib()
    {
        let icon = NSImage(named: NSImage.Name(rawValue: "Temporal-Icon"))
        // icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        temporalMenuItem = statusMenu.item(withTitle: "Temporal")
        temporalMenuItem.view = temporalView
        
        // Set timer format
        timeFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        showTime()
        
        // Negative value of timeInterval causes the timer to default to 0.1 ms
        timer = Timer.scheduledTimer(timeInterval: -1,
                                     target: self,
                                     selector: #selector(showTime),
                                     userInfo: nil,
                                     repeats: true)
        
        // add timer to RunLoop for handling during event loops
        RunLoop.current.add(timer, forMode: .eventTrackingRunLoopMode)
        
     
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
        
        
    }

}
