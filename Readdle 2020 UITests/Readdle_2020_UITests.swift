//
//  Readdle_2020_UITests.swift
//  Readdle 2020 UITests
//
//  Created by Eugene Ilyin on 31.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import XCTest
@testable import Readdle_2020

class Readdle_2020_UITests: XCTestCase {

    // MARK: - Properties
    
    var application: XCUIApplication!
    
    // MARK: - XCTestCase preparations
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        application = XCUIApplication()
        application.launch()
    }

    // MARK: - Tests

    func testPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testInitialStateIsCorrect() {
        /// Initially navigation bar is hiddent.
        XCTAssertEqual(application.navigationBars.count, 0)
        
        /// Since collectionView dequeues cells, it is hard to count all cells directly.
        /// So let's check that there are any cells.
        let collectionView = application.collectionViews
        XCTAssertEqual(collectionView.count, 1)
        XCTAssertTrue(collectionView.element.elementType == .collectionView)
        XCTAssertGreaterThanOrEqual(collectionView.cells.count, 2)
        
        let segmentedControl = application.segmentedControls
        XCTAssertEqual(segmentedControl.count, 1)
        XCTAssertTrue(segmentedControl.element.elementType == .segmentedControl)
        let listButton = segmentedControl.buttons["List"]
        let gridButton = segmentedControl.buttons["Grid"]
        XCTAssertNotNil(listButton)
        XCTAssertNotNil(gridButton)
        XCTAssertTrue(listButton.isSelected)
        XCTAssertTrue(gridButton.isSelected == false)
    }
    
    func testUserChangesSegmentedContol() {
        /// Since collectionView dequeues cells, it is hard to count all cells directly.
        /// But we will use this knowledge to count visible cells.
        /// Since we have several item / cell sizes, there will be difference in the number of visible cells.
        let collectionView = application.collectionViews
        let initialNumberOfVisibleCells = collectionView.cells.count
        
        let segmentedControl = application.segmentedControls
        let listButton = segmentedControl.buttons["List"]
        let gridButton = segmentedControl.buttons["Grid"]
        XCTAssertTrue(listButton.isSelected)
        XCTAssertTrue(gridButton.isSelected == false)
        
        gridButton.tap()
        XCTAssertTrue(listButton.isSelected == false)
        XCTAssertTrue(gridButton.isSelected)
        
        var currentNumberOfVisibleCells = collectionView.cells.count
        XCTAssertNotEqual(initialNumberOfVisibleCells, currentNumberOfVisibleCells)
        
        listButton.tap()
        XCTAssertTrue(listButton.isSelected)
        XCTAssertTrue(gridButton.isSelected == false)
        currentNumberOfVisibleCells = collectionView.cells.count
        XCTAssertEqual(initialNumberOfVisibleCells, currentNumberOfVisibleCells)
    }
    
    func testUserTapsFirstCell() {
        /// Since it is hard to track view controller while unit testing,
        /// we will test if new view controller is pushed to the navigation controllers.
        /// Initially the navigation bar is hidden,
        /// and when new view controller is pushed the navigation bar is shown,
        /// so we can use that.
        let collectionView = application.collectionViews
        let backButton = application.buttons["Back"]
        
        XCTAssertFalse(backButton.exists)
        XCTAssertEqual(application.navigationBars.count, 0)
        
        collectionView.cells.element(boundBy: 0).tap()
        
        XCTAssertEqual(application.navigationBars.count, 1)
        
        XCTAssertTrue(backButton.exists)
        backButton.tap()
        
        XCTAssertEqual(application.navigationBars.count, 0)
    }
}
