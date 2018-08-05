//
//  CalendarDateItem.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 6/23/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

@IBDesignable class CalendarDateItem: NSCollectionViewItem {
    
    var backColor: NSColor = NSColor.lightGray
    var textColor: NSColor = NSColor.windowFrameTextColor
    var titleTextColor: NSColor = NSColor.white
    var borderColor: NSColor = NSColor.black
    var highlightColor: NSColor = NSColor.orange
    
    
    var theme = "Night"
    
    var dateText: String = "" {
        didSet {
            guard isViewLoaded else { return }
            textField?.stringValue = dateText
            
            
        }
    }
    
    var isToday: Bool = false
    {
        didSet {
            
            if isToday
            {
                self.textColor = self.highlightColor
            }
        
            view.layer?.backgroundColor = self.backColor.cgColor
            view.layer?.borderColor = self.borderColor.cgColor
            self.textField?.textColor = self.textColor
            
        }
    }
    
    
  
    
    var otherMonthDate: Bool = false
    {
        didSet {
            
            
            
            if otherMonthDate
            {
                self.textColor = NSColor.init(calibratedWhite: 1.0, alpha: 0.6)
                
            }
            
            view.layer?.backgroundColor = self.backColor.cgColor
            view.layer?.borderColor = self.borderColor.cgColor
            self.textField?.textColor = self.textColor
            
        }
        
    }


    
    @IBInspectable var titleItem: Bool = false
    {
        didSet {
          
                (self.backColor,self.textColor) = titleItem ? (self.highlightColor, self.titleTextColor): (self.backColor,self.textColor)
            
                view.layer?.backgroundColor = self.backColor.cgColor
                view.layer?.borderColor = self.borderColor.cgColor
                view.layer?.borderWidth = 0.0
                self.textField?.textColor = self.textColor
                
            }
        
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.wantsLayer = true
        
        view.layer?.cornerRadius = view.frame.height / 20

        
        
    }
    
    func setTheme(theme: String)
    
    {
        if let themeColors = CalendarView.calendarThemeColors[theme]
        {
            self.theme = theme
            self.backColor = themeColors["backgroundColor"]!
            self.textColor = themeColors["textColor"]!
            self.titleTextColor =  themeColors["titleTextColor"]!
            self.highlightColor = themeColors["highlightColor"]!
    
        }
    
    }
    
}
