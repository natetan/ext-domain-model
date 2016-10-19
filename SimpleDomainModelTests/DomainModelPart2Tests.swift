//
//  DomainModelPart2Tests.swift
//  SimpleDomainModel
//
//  Created by Yulong Tan on 10/18/16.
//  Copyright © 2016 Yulong Tan. All rights reserved.
//

import XCTest

class DomainModelPart2Tests: XCTestCase {
    
    func testDescriptions() {
        let moneyTest1 = Money(amount: 10, currency: "USD")
        let moneyTest2 = Money(amount: 100, currency: "CAN")
        let moneyTest3 = Money(amount: 1000, currency: "EUR")
        let moneyTest4 = Money(amount: 1, currency: "GBP")
        
        XCTAssert(moneyTest1.description == "USD10.0")
        XCTAssert(moneyTest2.description == "CAN100.0")
        XCTAssert(moneyTest3.description == "EUR1000.0")
        XCTAssert(moneyTest4.description == "GBP1.0")
        
        let jobTest = Job(title: "McDonalds", type: Job.JobType.Hourly(4))
        XCTAssert(jobTest.description == "Works at McDonalds and gets paid 40")
        
        let matt = Person(firstName: "Matthew", lastName: "Neward", age: 15)
        
        matt.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(matt.job == nil)
        
        matt.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(matt.description == "Matthew Neward: {job: no job | spouse: not married}")
    }
    
    func testMath() {
        let moneyTestAdd1 = Money(amount: 10, currency: "USD")
        let moneyTestAdd2 = Money(amount: 15, currency: "USD")
        let addResult = Money(amount: 25, currency: "USD")
        XCTAssert(moneyTestAdd1.add(moneyTestAdd2).amount == addResult.amount && moneyTestAdd1.add(moneyTestAdd2).currency == addResult.currency)
        
        let moneyTestSub1 = Money(amount: 25, currency: "USD")
        let moneyTestSub2 = Money(amount: 15, currency: "USD")
        let subResult = Money(amount: 10, currency: "USD")
        XCTAssert(moneyTestSub1.subtract(moneyTestSub2).amount == subResult.amount && moneyTestSub1.subtract(moneyTestSub2).currency == subResult.currency)
    }
    
    func testExtensions() {
        let test1 = Money(amount: 10, currency: "YEN")
        let test1Ext = 10.YEN
        
        let test2 = Money(amount: 15, currency: "EUR")
        let test2Ext = 15.EUR
        XCTAssert(test2Ext.amount == test2.amount && test2Ext.currency == test2.currency)
    }

}
