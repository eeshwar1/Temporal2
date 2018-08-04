//
//  CalendarDateItem.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 6/23/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

@IBDesignable class CalendarDateItem: NSCollectionViewItem {
    
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
                self.textColor = NSColor.white
            }
        
            view.layer?.backgroundColor = self.backColor.cgColor
            view.layer?.borderColor = self.borderColor.cgColor
            self.textField?.textColor = self.textColor
            
        }
    }
    
    
  
    
    var otherMonthDate: Bool = false
    {
        didSet {
            
            
            
            self.textColor = otherMonthDate ? NSColor.disabledControlTextColor : NSColor.windowFrameTextColor
            
            view.layer?.backgroundColor = self.backColor.cgColor
            view.layer?.borderColor = self.borderColor.cgColor
            self.textField?.textColor = self.textColor
            
        }
        
    }

    var backColor: NSColor = NSColor.lightGray
    var textColor: NSColor = NSColor.windowFrameTextColor
    var borderColor: NSColor = NSColor.black
    
    @IBInspectable var titleItem: Bool = false
    {
        didSet {
          
            if titleItem {
                
                (self.backColor,self.textColor) = (NSColor.orange
                    , NSColor.windowFrameTextColor)
            }
            else
            {
                (self.backColor,self.textColor) = (NSColor.windowFrameColor
                    , NSColor.windowFrameTextColor)
                
            }
                
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
    
}
