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
    
    @IBOutlet var calendarView: CalendarView!
    
    
    required init?(coder decoder: NSCoder) {
        
        super.init(coder: decoder)
     
        self.calendarView = CalendarView()
    
    }
    
    required override init(frame frameRect: NSRect) {
       
        super.init(frame: frameRect)
        
        let cView = CalendarView()
        
        self.calendarView.addSubview(cView)
        
        
    }
    
    func setTime(time: Time)
    {
        self.clockView.setTime(hours: time.hours, minutes: time.minutes, seconds: time.seconds)
        
        self.clockLabel.stringValue = time.timeString
        
        self.setNeedsDisplay(bounds)
        
        
        self.calendarView.setNeedsDisplay(self.calendarView.bounds)
      
    }
    
    func setTheme(theme: String)
    {
        self.clockView.setTheme(theme: theme)
        self.calendarView.setTheme(theme: theme)
    }
    
}
