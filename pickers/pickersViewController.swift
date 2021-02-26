//
//  ViewController.swift
//  pickers
//
//  Created by Peter Rasmussen on 2/22/21.
//
//  Framework on how to setup pickers with dates and items from lists
//  I created this swift code as part of my ressearch into pickers
//  to be used in my final project for CS50. Here I could experiment
//  without messing up the CS50 project that was already 80-90 % done
//
//  Layout constraints for the storyboard has been ignored as the main
//  objective is to work out the basic functionality to be used in other
//  projects, this is not intended to be a completed app.
//
//  This is a work-in-progress, as I get more experience I might update this guide
//
//  As is, the item picker is initiated from the text field because
//  of the 2 datasources. Otherwise could be included in viewDidLoad #A-1
//
//  The item picker locates the value already in the input text field #A-2
//
//  If user taps outside the picker/input field, the picker is dismissed #A-3
//
//  The date picker is initiated with the date already in the input field #B-1
//  If blank, date is set to system date
//
//  Change log:
//      2021-02-25: Initial version
//
//

import UIKit
import Foundation

class pickersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var fruits = ["Apple", "Pear", "Banana", "Orange", "Pineapple"]
    var names = ["Jeff", "Nina", "Lisa", "Riley", "John", "Michael"]
    var selectedPickerRow = 0
    var itemPicker: UIPickerView!
    
    
    @IBOutlet var fruit: UITextField!
    @IBOutlet var name: UITextField!
    
    // Create picker when field is activated  #A-1
    @IBAction func fruitEditBegin(_ sender: Any) {
        //print("fruit begins")
        createItemPicker()
        // Locate in picker the item already in text field   #A-2
        let index = fruits.firstIndex(where: {$0 == fruit.text })
        itemPicker.selectRow(index ?? 0, inComponent: 0, animated: true)
    }
    
    // Create picker when field is activated  #A-1
    @IBAction func nameEditBegin(_ sender: Any) {
        //print("name begins")
        createItemPicker()
        // Locate in picker the item already in text field   #A-2
        let index = names.firstIndex(where: {$0 == name.text })
        itemPicker.selectRow(index ?? 0, inComponent: 0, animated: true)
    }
    
    
    @IBOutlet var inputDate1: UITextField!
    @IBOutlet var inputDate2: UITextField!
    
    @IBAction func inputDate1EditBegin(_ sender: Any) {
        createDatePicker()
    }
    
    @IBAction func inputDate2EditBegin(_ sender: Any) {
        createDatePicker()
    }
    
    let dateFormatter = DateFormatter()
    
    // Picker for items from list  ---  START  ---
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print("picker: number of rows")
        if fruit.isFirstResponder {
            return fruits.count
        }
        else if name.isFirstResponder {
            return names.count
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print("picker: add data to picker")
        if fruit.isFirstResponder {
            return fruits[row]
        }
        else if name.isFirstResponder {
            return names[row]
        }
        else {
            return "Not found"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("picker: selecting row")
        // Save the selected row to use in tapDone
        selectedPickerRow = row
    }
    
    func createItemPicker() {
        //print("Creating new picker ...")
        let screenWidth = UIScreen.main.bounds.width
        
        itemPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        itemPicker.sizeToFit()
        itemPicker.delegate = self
        
        if fruit.isFirstResponder {
            fruit.inputView = itemPicker
        }
        else if name.isFirstResponder {
            name.inputView = itemPicker
        }
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 45.0))
        
        
        // "flexible" is used as a filler between tollBar buttons
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // #selector(..) is used to call the @objc func when that button is tapped
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(tapDone))
        let new = UIBarButtonItem(title: "Add New", style: .plain, target: target, action: #selector(tapNew))
        
        toolBar.setItems([cancel, flexible, new, flexible, done], animated: false)
        
        if fruit.isFirstResponder {
            fruit.inputAccessoryView = toolBar
        }
        else if name.isFirstResponder {
            name.inputAccessoryView = toolBar
        }
    }
    
    @objc func tapDone() {
        if fruit.isFirstResponder {
            fruit.text = fruits[selectedPickerRow]
        }
        else if name.isFirstResponder {
            name.text = names[selectedPickerRow]
        }
        view.endEditing(true)
    }
    
    @objc func tapCancel() {
        view.endEditing(true)
    }
    
    @objc func tapNew() {
        //print("Add new item in list ....")
        // Add functionality here to add new items to list,
        // not part of this framework :)
    }
    
    
    // *** Picker for items from list  ---  END  ---
    
    
    // *** Date picker                 ---  START  ---
    
    func createDatePicker() {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 45.0))
        
        // "flexible" is used as a filler between tollBar buttons
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // #selector(..) is used to call the @objc func when that button is tapped
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapDateCancel))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(tapDateDone))
        toolBar.setItems([cancel, flexible, done], animated: false)
        
        if inputDate1.isFirstResponder {
            inputDate1.inputView = datePicker
            inputDate1.inputAccessoryView = toolBar
            setDateForDatePicker(datePicker: datePicker, dateString: inputDate1.text ?? " ")
        }
        else if inputDate2.isFirstResponder {
            inputDate2.inputView = datePicker
            inputDate2.inputAccessoryView = toolBar
            setDateForDatePicker(datePicker: datePicker, dateString: inputDate2.text ?? " ")
        }
        
    }
    
    // Set default date to show for the date picker       #B-1
    func setDateForDatePicker(datePicker: UIDatePicker, dateString: String) {
        if let date = dateFormatter.date(from: dateString) {
            datePicker.date = date
        }
    }
    
    
    
    @objc func tapDateDone() {
        if inputDate1.isFirstResponder {
            if let datePicker = inputDate1.inputView as? UIDatePicker {
                inputDate1.text = dateFormatter.string(from: datePicker.date)
            }
            //inputDate1.resignFirstResponder()
        }
        else if inputDate2.isFirstResponder {
            if let datePicker = inputDate2.inputView as? UIDatePicker {
                inputDate2.text = dateFormatter.string(from: datePicker.date)
            }
        }
        view.endEditing(true)
    }
    
    // Could use same function for cancel as the item picker
    @objc func tapDateCancel() {
        view.endEditing(true)
    }
    
    // *** Date picker     ---  END  ---
    
    
    // Hide picker/keyboard when user taps outside textfield   #A-3
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Sort the lists, normally better idea to load list sorted
        // Sort used here for testing
        fruits.sort()
        names.sort()
        
        // If only one item picker, it can be initiated from here
        // instead of from the @IBAction
        //createItemPicker()
        
        // According to several googles there is a bug in the Input Assistant View (Apple)
        // ... when jumping to next field without having fully dismissed the keyboard/Picker
        // Setting autocorrectionType to .no will silence the constraint warning
        fruit.autocorrectionType = .no
        name.autocorrectionType = .no
        inputDate1.autocorrectionType = .no
        inputDate2.autocorrectionType = .no
        
        // Set date format
        dateFormatter.dateStyle = .medium
        //createDatePicker()
    }

}

