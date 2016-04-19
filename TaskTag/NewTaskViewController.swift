//
//  NewTaskViewController.swift
//  TaskTag
//
//  Created by Tim Glorioso on 4/18/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import UIKit

class NewTaskViewController: UITableViewController, UITextFieldDelegate {

   @IBOutlet weak var nameTextField: UITextField!
   @IBOutlet weak var tagsTextField: UITextField!

   @IBOutlet weak var dueDateLabel: UILabel!
   @IBOutlet weak var priorityLabel: UILabel!
   @IBOutlet weak var timeLeftLabel: UILabel!

   var newTask: Task?

   @IBAction func cancel(sender: UIBarButtonItem) {
      dismissViewControllerAnimated(true, completion: nil)
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

      let separators = NSCharacterSet(charactersInString: " ,")
      let tags = tagsTextField.text?.componentsSeparatedByCharactersInSet(separators)

      newTask = Task(nameTextField.text!, withTags: tags)
   }

   func textFieldDidEndEditing(textField: UITextField) {

      if textField === nameTextField && textField.text?.isEmpty == false {
         navigationItem.rightBarButtonItem?.enabled = true
      }
   }

   func textFieldShouldReturn(textField: UITextField) -> Bool {

      textField.resignFirstResponder()
      return true
   }
}
