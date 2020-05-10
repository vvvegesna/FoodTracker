//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Vegesna, Vijay V EX1 on 5/3/20.
//  Copyright © 2020 Vegesna, Vijay V EX1. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    //MARK: Meal class test cases
    
    func testMealInitializationSuceed() {
        let meal = Meal(name: "fish", photo: nil, rating: 4)
        XCTAssertNotNil(meal)
    }
    
    func testMealInitializationFaild() {
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
         
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    }

}
