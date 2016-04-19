//
//  TagsViewController.swift
//  TaskTag
//
//  Created by Tim Glorioso on 4/19/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import UIKit

class TagsViewController: UITableViewController {

   var allTags: [String]?
   lazy var selectedTags = [String]()

   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return allTags!.count
   }

   override func tableView(tableView: UITableView,
                           cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      let cell = tableView.dequeueReusableCellWithIdentifier("TagCell", forIndexPath: indexPath)
      cell.textLabel?.text = allTags![indexPath.row]

      return cell
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

      if let selectedIndexPaths = tableView.indexPathsForSelectedRows {

         for indexPath in selectedIndexPaths {
            let selectedCell = tableView.cellForRowAtIndexPath(indexPath)

            if let tag = selectedCell?.textLabel?.text {
               selectedTags.append(tag)
            }
         }
      }
   }

}
