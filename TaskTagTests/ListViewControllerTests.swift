//
//  ListViewControllerTests.swift
//  TaskTag
//
//  Created by Tim Glorioso on 4/19/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import XCTest
@testable import TaskTag

// This class tests the ListViewController by instantiating it from the Main storyboard
class ListViewControllerTests: XCTestCase {

   var listViewController: ListViewController?

   override func setUp() {
      super.setUp()

      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      listViewController = storyboard.instantiateViewControllerWithIdentifier("ListViewController")
         as? ListViewController
   }

   // This method tests that the ListViewControllers tag array won't contain duplicate tags
   func testNoDuplicateTags() {

      // create a Task with duplicate tags
      let task = Task("test task", withTags: ["leisure", "bogus", "leisure"])

      // ensure setUp initialized a ListViewController
      if listViewController != nil {

         // save the test Task
         listViewController!.saveNewTask(task)

         // ensure ListViewController's tags model data structure contains no duplicates
         XCTAssertTrue(listViewController!.tags == ["leisure", "bogus"])
      } else {
         XCTFail("listViewController was nil")
      }
   }
}