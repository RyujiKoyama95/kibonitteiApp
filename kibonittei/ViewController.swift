//
//  ViewController.swift
//  kibonittei
//
//  Created by 小山竜二 on 2022/02/05.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic

class ViewController: UIViewController {
    
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var finishTimeLabel: UILabel!
    
    var timeLabel1 = ""
    var timeLabel2 = ""
    var tag: Int = 0
    var cellIdentifier = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView2.delegate = self
        tableView2.dataSource = self
        
        startTimeLabel.text = "開始時刻"
        finishTimeLabel.text = "終了時刻"
        textView.text = "希望日程は下記です。"
        
        //        self.calendar.appearance.headerDateFormat = "YYYY年MM月"
        //        self.calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        //        self.calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        //        self.calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        //        self.calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        //        self.calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        //        self.calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        //        self.calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func copyButton(_ sender: Any) {
        UIPasteboard.general.string = self.textView.text
    }
    
    @IBAction func resetButton(_ sender: Any) {
        self.textView.text = "希望日程は下記です。"
    }
}


extension ViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let tmpDate = Calendar(identifier: .gregorian)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        self.textView.insertText("\n・\(month)月\(day)日")
        
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func checkTableView(_ tableView: UITableView) -> Void{
            if (tableView.tag == 1) {
                tag = 1
                cellIdentifier = "firstCell"
            }
            else if (tableView.tag == 2) {
                tag = 2
                cellIdentifier = "secondCell"
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkTableView(tableView)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = timeList[indexPath.row]
        
//        timeLabel1 = (cell.textLabel?.text)!
//        timeLabel2 = (cell.textLabel?.text)!
        
        print("cellForRowAtが呼ばれた")
        print("\(indexPath.row) = \(timeList[indexPath.row]) = \(timeLabel1)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.tag == 1) {
            self.textView.insertText(" " + timeList[indexPath.row] + "〜 ")
        }
        else if (tableView.tag == 2) {
            self.textView.insertText(timeList[indexPath.row])
        }
        
        print("didSelectRowAt\(indexPath.row)が呼ばれた")
        print("\(indexPath.row) = \(timeList[indexPath.row]) = \(timeLabel1)")
        
    }
    
}

