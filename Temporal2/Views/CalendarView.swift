//
//  CalendarView.swift
//  Temporal
//
//  Created by Venky Venkatakrishnan on 7/23/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

class CalendarView: NSView {

    
    @IBOutlet var calendarView: NSView!
    @IBOutlet weak var lblMonthName: NSTextField!
    
    @IBOutlet weak var buttonPrevMonth: NSButton!
    @IBOutlet weak var buttonNextMonth: NSButton!
    
    @IBOutlet weak var buttonPrevYear: NSButton!
    @IBOutlet weak var buttonNextYear: NSButton!
    
    @IBOutlet weak var buttonToday: NSButton!
    
    fileprivate var clockThemes: [String] = []
    
    fileprivate var dates: [Int] = Array(1...31)
    
    fileprivate var dayNames: [String] = ["S","M","T","W","T","F","S"]
    
    var datesPerSection = 7
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var calendarMonth: CalendarMonth = CalendarMonth()
    
    var todayDay: Int = 0
    var todayMonth: Int = 0
    var todayYear: Int = 0
    
    
    required init?(coder decoder: NSCoder) {
        
        super.init(coder: decoder)        
        
        commonInit()
        
    }
    required override init(frame frameRect: NSRect) {
        
        super.init(frame: frameRect)
        
        commonInit()
    }
    
    func commonInit()
    {
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "CalendarView"), owner: self, topLevelObjects: nil)
        
        let contentFrame = NSMakeRect(0, 0, frame.size.width, frame.size.height)
        
        self.calendarView.frame = contentFrame
        
        self.addSubview(self.calendarView)
        
        configureCollectionView()
        
        showDate()
    }
    
    func showDate()
    {
        
        let date = Date()
        
        let calendar = Calendar.current
        
        self.todayDay = calendar.component(.day, from: date)
        self.todayMonth = calendar.component(.month, from: date)
        self.todayYear = calendar.component(.year, from: date)
        
        self.calendarMonth.setMonthAndYear(month: self.todayMonth,
                                           year: self.todayYear)
        
        lblMonthName.stringValue = calendarMonth.monthAndYear
        
    }

    
    private func configureCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 30.0,
                                     height: 30.0)
        flowLayout.sectionInset = NSEdgeInsets(top: 2.0,
                                               left: 2.0,
                                               bottom: 2.0,
                                               right: 2.0)
        flowLayout.minimumInteritemSpacing = 0.25
        flowLayout.minimumLineSpacing = 0.25
        
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.wantsLayer = true
        
        collectionView.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
    }
    
    // Actions
    
    @IBAction func clickNextMonth(_ sender: Any) {
        
        
        var dateComponents = DateComponents()
        dateComponents.month = self.calendarMonth.month
        dateComponents.year = self.calendarMonth.year
        dateComponents.day  = 1
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: dateComponents)!
        
        dateComponents.month = 1
        dateComponents.day = 0
        dateComponents.year = 0
        
        let nextMonthDate = calendar.date(byAdding: dateComponents, to: date)!
        
        let nextMonthDateMonth = calendar.component(.month, from: nextMonthDate)
        let nextMonthDateYear = calendar.component(.year, from: nextMonthDate)
        
        self.calendarMonth.setMonthAndYear(month: nextMonthDateMonth, year: nextMonthDateYear)
        
        self.collectionView.reloadData()
        
        lblMonthName.stringValue = calendarMonth.monthAndYear
        
    }
    
    
    @IBAction func clickPrevMonth(_ sender: Any) {
        
        
        var dateComponents = DateComponents()
        dateComponents.month = self.calendarMonth.month
        dateComponents.year = self.calendarMonth.year
        dateComponents.day  = 1
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: dateComponents)!
        
        dateComponents.month = -1
        dateComponents.day = 0
        dateComponents.year = 0
        
        let prevMonthDate = calendar.date(byAdding: dateComponents, to: date)!
        
        let prevMonthDateMonth = calendar.component(.month, from: prevMonthDate)
        let prevMonthDateYear = calendar.component(.year, from: prevMonthDate)
        
        self.calendarMonth.setMonthAndYear(month: prevMonthDateMonth, year: prevMonthDateYear)
        
        self.collectionView.reloadData()
        
        lblMonthName.stringValue = calendarMonth.monthAndYear
    }
    
    @IBAction func clickPrevYear(_ sender: Any) {
        
        
        var dateComponents = DateComponents()
        dateComponents.month = self.calendarMonth.month
        dateComponents.year = self.calendarMonth.year
        dateComponents.day  = 1
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: dateComponents)!
        
        dateComponents.month = 0
        dateComponents.day = 0
        dateComponents.year = -1
        
        let prevYearDate = calendar.date(byAdding: dateComponents, to: date)!
        
        let prevYearDateMonth = calendar.component(.month, from: prevYearDate)
        let prevYearDateYear = calendar.component(.year, from: prevYearDate)
        
        self.calendarMonth.setMonthAndYear(month: prevYearDateMonth, year: prevYearDateYear)
        
        self.collectionView.reloadData()
        
        lblMonthName.stringValue = calendarMonth.monthAndYear
    }
    
    @IBAction func clickNextYear(_ sender: Any) {
        
        
        var dateComponents = DateComponents()
        dateComponents.month = self.calendarMonth.month
        dateComponents.year = self.calendarMonth.year
        dateComponents.day  = 1
        
        let calendar = Calendar.current
        
        let date = calendar.date(from: dateComponents)!
        
        dateComponents.month = 0
        dateComponents.day = 0
        dateComponents.year = 1
        
        let nextYearDate = calendar.date(byAdding: dateComponents, to: date)!
        
        let nextYearDateMonth = calendar.component(.month,
                                                   from: nextYearDate)
        let nextYearDateYear = calendar.component(.year,
                                                  from: nextYearDate)
        
        self.calendarMonth.setMonthAndYear(month: nextYearDateMonth,
                                           year: nextYearDateYear)
        
        self.collectionView.reloadData()
        
        lblMonthName.stringValue = calendarMonth.monthAndYear
    }
    
    @IBAction func clickToday(_ sender: Any)
    {
        let today = Date()
        let calendar = Calendar.current
        
        let todayMonth = calendar.component(.month, from: today)
        let todayYear =  calendar.component(.year, from: today)
        
        self.calendarMonth.setMonthAndYear(month: todayMonth,
                                           year: todayYear)
        
        self.collectionView.reloadData()
        
        lblMonthName.stringValue = calendarMonth.monthAndYear
    }
}

extension CalendarView: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
      
        
        return 7
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return datesPerSection
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CalendarDateItem"), for: indexPath)
        
        guard let calendarDateItem = item as? CalendarDateItem else { return item }
        
        var currentIndex: Int = 0
        
        // Title row
        if indexPath.section == 0
        {
            calendarDateItem.dateText = dayNames[indexPath.item]
            calendarDateItem.titleItem = true
        }
        else if indexPath.section == 1
        {
            if indexPath.item < self.calendarMonth.firstDayOfMonthWeekDay - 1
            {
                
                calendarDateItem.dateText  = ""
            }
            else
            {
                currentIndex = (indexPath.section  - 1) * 7 +
                    
                    indexPath.item - self.calendarMonth.firstDayOfMonthWeekDay + 1
                
                if currentIndex <= self.calendarMonth.dates.count - 1
                {
                    calendarDateItem.dateText = String(describing: self.calendarMonth.dates[currentIndex])
                }
                else
                {
                    calendarDateItem.dateText  = ""
                }
                
            }
            
            calendarDateItem.titleItem = false
        }
        else {
            
            currentIndex = (indexPath.section  - 1) * 7 +
                
                indexPath.item - self.calendarMonth.firstDayOfMonthWeekDay + 1
            
            if currentIndex <= self.calendarMonth.dates.count - 1
            {
                calendarDateItem.dateText = String(describing: self.calendarMonth.dates[currentIndex])
            }
            else
            {
                calendarDateItem.dateText  = ""
            }
            calendarDateItem.titleItem = false
            
        }
        
        // Check for today's date and set flag for highlighting
        if currentIndex <= self.calendarMonth.dates.count - 1
        {
            if self.calendarMonth.dates[currentIndex] == self.todayDay &&
                self.calendarMonth.month == self.todayMonth &&
                self.calendarMonth.year == self.todayYear
            {
                calendarDateItem.isToday = true
            }
        }
        
        
        
        return calendarDateItem
        
    }
    
}

