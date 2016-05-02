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
   var selectedTags: Set<String>?

   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return allTags!.count
   }

   override func tableView(tableView: UITableView,
                           cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      let cell = tableView.dequeueReusableCellWithIdentifier("TagCell", forIndexPath: indexPath)
      let tagName = allTags![indexPath.row]

      if tagName.isEmpty == false {
         cell.textLabel?.text = allTags![indexPath.row]
      } else {
         cell.textLabel?.text = "untagged"
         cell.textLabel?.textColor = UIColor.darkGrayColor()
      }

      if selectedTags!.contains(tagName) {
         cell.accessoryType = .Checkmark
         tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
      }

      return cell
   }

   override func tableView(tableView: UITableView,
                           willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {

      print("selecting")

      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
         cell.accessoryType = .Checkmark
         selectedTags!.insert(cell.textLabel!.text!)
      }

      return indexPath
   }

   override func tableView(tableView: UITableView,
                           willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {

      print("deselecting")

      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
         cell.accessoryType = .None
         if cell.textLabel!.text! == "untagged" {
            selectedTags!.remove("")
         } else {
            selectedTags!.remove(cell.textLabel!.text!)
         }
      }

      return indexPath
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

      if let selectedIndexPaths = tableView.indexPathsForSelectedRows {

         for indexPath in selectedIndexPaths {
            let selectedCell = tableView.cellForRowAtIndexPath(indexPath)

            if let tag = selectedCell?.textLabel?.text {
               if tag == "untagged" {
                  selectedTags!.insert("")
                  selectedTags!.remove("untagged")
               } else {
                  selectedTags!.insert(tag)
               }
            }
         }
      }
   }

}
