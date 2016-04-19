//
//  NewTaskViewController.swift
//  TaskTag
//
//  Created by Tim Glorioso on 4/18/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import UIKit

class NewTaskViewController: UITableViewController {

   @IBAction func cancel(sender: UIBarButtonItem) {
      dismissViewControllerAnimated(true, completion: nil)
   }
}
