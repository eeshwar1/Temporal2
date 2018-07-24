//
//  CollectionViewItem.swift
//  Temporal
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
                self.backColor = NSColor.gray
                self.textColor = NSColor.green
            }
            view.layer?.backgroundColor = self.backColor.cgColor
            view.layer?.borderColor = self.borderColor.cgColor
            self.textField?.textColor = self.textColor
            
        }
    }
    
    var backColor: NSColor = NSColor.lightGray
    var textColor: NSColor = NSColor.blue
    var borderColor: NSColor = NSColor.white
    
    @IBInspectable var titleItem: Bool = false
    {
        didSet {
            
            
            (self.backColor,self.textColor) = titleItem ? (NSColor.orange
                , NSColor.white) : (NSColor.white, NSColor.darkGray)
            
           
            
            view.layer?.backgroundColor = self.backColor.cgColor
            view.layer?.borderColor = self.borderColor.cgColor
            view.layer?.borderWidth = 1.0
            self.textField?.textColor = self.textColor
            
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.wantsLayer = true
        
        
    }
    
}
