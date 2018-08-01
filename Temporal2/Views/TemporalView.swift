//
//  TemporalView.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 7/22/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa



class TemporalView: NSView {

    @IBOutlet weak var clockLabel: NSTextField!
    
    @IBOutlet weak var clockView: ClockView!
    
    @IBOutlet weak var calendarView: CalendarView!
    
    
    required init?(coder decoder: NSCoder) {
        
        super.init(coder: decoder)
     
        self.calendarView = CalendarView(frame: NSMakeRect(0, 0, 300, 300))
    
    }
    
    required override init(frame frameRect: NSRect) {
       
        super.init(frame: frameRect)
        
        let cView = CalendarView(frame: NSMakeRect(0, 0, 300, 300))
        
        self.calendarView.addSubview(cView)
    }
    
    func setTime(time: Time)
    {
        self.clockView.setTime(hours: time.hours, minutes: time.minutes, seconds: time.seconds)
        
        self.clockLabel.stringValue = time.timeString
        
        self.setNeedsDisplay(bounds)
      
    }
    
    func setTheme(theme: String)
    {
        let defaults = UserDefaults.standard
        let theme =  defaults.string(forKey: "Theme") ?? DEFAULT_THEME
        self.clockView.setTheme(theme: theme)
    }
    
}
