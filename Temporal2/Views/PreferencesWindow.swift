//
//  PreferencesWindow.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 7/28/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSComboBoxDelegate, NSWindowDelegate {
   
    @IBOutlet weak var themeCombo: NSComboBox!
    @IBOutlet weak var clockView: ClockView!
    
    @IBOutlet weak var timeformatSegmentedControl: NSSegmentedControl!
    
    
    
    var delegate: PreferencesWindowDelegate?
    
    override var windowNibName: NSNib.Name?{
        return "PreferencesWindow"
        
    }
    override func windowDidLoad() {
        super.windowDidLoad()
        
        

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
       
        
        let clockThemes = ClockView.getThemes()
        themeCombo.removeAllItems()
        themeCombo.addItems(withObjectValues: clockThemes)
        
        let defaults = UserDefaults.standard
        let theme = defaults.string(forKey: "Theme") ?? DEFAULT_THEME
        themeCombo.selectItem(withObjectValue: theme)
        
        let timeFormat = defaults.string(forKey: "Time Format") ?? DEFAULT_TIME_FORMAT
        timeformatSegmentedControl.selectedSegment = timeFormat == "12h" ? 0 : 1
        
        self.clockView.setTheme(theme: theme)
        self.clockView.setTime(hours: 10, minutes: 10, seconds: 40)
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
    }
    
    // ComboBox Delegate
    
    func comboBoxSelectionIsChanging(_ notification: Notification) {
        let comboBox = (notification.object as? NSComboBox)!
        
        if comboBox.identifier!.rawValue == "clockThemeCombo"
        {
            
            self.clockView.setTheme(theme: self.themeCombo.itemObjectValue(at: self.themeCombo.indexOfSelectedItem) as! String)
            self.clockView.setNeedsDisplay(self.clockView.bounds)
            
        }
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let comboBox = (notification.object as? NSComboBox)!
        
        if comboBox.identifier!.rawValue == "clockThemeCombo"
        {
            
            self.clockView.setTheme(theme: self.themeCombo.itemObjectValue(at: self.themeCombo.indexOfSelectedItem) as! String)
            self.clockView.setNeedsDisplay(self.clockView.bounds)
            
        }
    }
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.setValue(themeCombo.stringValue, forKey: "Theme")
    }
    
    // Actions
    
    @IBAction func clockStyleChanged(_ sender: AnyObject)
    {
        let defaults = UserDefaults.standard
        let timeFormatStyle = timeformatSegmentedControl.selectedSegment == 0 ? "12h" : "24h"
        defaults.setValue(timeFormatStyle, forKey: "Time Format")
        
    }
    
}
