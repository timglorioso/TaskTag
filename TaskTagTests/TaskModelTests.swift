//
//  TaskModelTests.swift
//  TaskTagTests
//
//  Created by Tim Glorioso on 4/18/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import XCTest
@testable import TaskTag

class TaskModelTests: XCTestCase {

   func testNoDuplicateTags() {

      // create a Task with duplicate tags
      let task = Task("test task", withTags: ["leisure", "bogus", "leisure"])

      // assert that duplicates are removed during Task initialization
      XCTAssertTrue(task.tags == ["leisure", "bogus"])
   }

   func testNoEmptyTags() {

      // create a Task with empty tags
      let task = Task("test task", withTags: ["", "bogus", "", "a real tag", ""])

      // assert that empty tags are removed during Task initialization
      XCTAssertTrue(task.tags == ["bogus", "a real tag"])
   }

}
