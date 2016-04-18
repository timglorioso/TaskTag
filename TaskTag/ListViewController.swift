//
//  ListViewController.swift
//  TaskTag
//
//  Created by Tim Glorioso on 4/18/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 0
   }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      return UITableViewCell()
   }
}

