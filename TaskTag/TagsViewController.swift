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

   var selectionButtons = [String: UIBarButtonItem]()

   override func viewDidLoad() {
      createSelectionButtons()
      updateSelectionButton()
   }

   func createSelectionButtons() {
      selectionButtons["select"] = UIBarButtonItem(title: "Select All", style: .Plain,
                                                   target: self,
                                                   action: #selector(toggleTagSelection))
      selectionButtons["deselect"] = UIBarButtonItem(title: "Deselect All", style: .Plain,
                                                     target: self,
                                                     action: #selector(toggleTagSelection))
      selectionButtons["select"]!.tintColor = UIColor.whiteColor()
      selectionButtons["deselect"]!.tintColor = UIColor.whiteColor()
   }

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

      updateForSelectedCellAtIndexPath(indexPath)
      updateSelectionButton()
      return indexPath
   }

   override func tableView(tableView: UITableView,
                           willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {

      updateForDeselectedCellAtIndexPath(indexPath)
      updateSelectionButton()
      return indexPath
   }

   func toggleTagSelection(sender: UIBarButtonItem) {
      if sender.title == "Deselect All" {
         for tagIndex in 0..<allTags!.count {
            let indexPath = NSIndexPath(forRow: tagIndex, inSection: 0)
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            updateForDeselectedCellAtIndexPath(indexPath)
         }
      } else if sender.title == "Select All" {
         for tagIndex in 0..<allTags!.count {
            let indexPath = NSIndexPath(forRow: tagIndex, inSection: 0)
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
            updateForSelectedCellAtIndexPath(indexPath)
         }
      }
      updateSelectionButton()
   }

   func updateSelectionButton() {
      if selectedTags!.count > allTags!.count / 2 {
         navigationItem.setLeftBarButtonItem(selectionButtons["deselect"], animated: true)
      } else {
         navigationItem.setLeftBarButtonItem(selectionButtons["select"], animated: true)
      }
   }

   func updateForSelectedCellAtIndexPath(indexPath: NSIndexPath) {

      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
         cell.accessoryType = .Checkmark
         if cell.textLabel!.text! == "untagged" {
            selectedTags!.insert("")
         } else {
            selectedTags!.insert(cell.textLabel!.text!)
         }
      }
   }

   func updateForDeselectedCellAtIndexPath(indexPath: NSIndexPath) {

      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
         cell.accessoryType = .None
         if cell.textLabel!.text! == "untagged" {
            selectedTags!.remove("")
         } else {
            selectedTags!.remove(cell.textLabel!.text!)
         }
      }
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // ... (nothing?)
   }

}
