//
//  main.swift
//  SimpleDomainModel
//
//  Created by Yulong Tan on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

protocol CustomStringConvertible {
    var description : String {
        get
    }
}

protocol Mathematics {
    func add(_: Money) -> Money
    func subtract(_: Money) -> Money
}

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {

    public var amount : Int
    public var currency : String
    
    var description: String {
        return ("\(currency)\(Double(amount))")
    }
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    public func convert(_ to: String) -> Money {
        var money = self.amount // 10 USD
        
        if (to != "USD") { // from USD
            if (to == "GBP") {
                money = money / 2
            } else if (to == "EUR") {
                money = money * 3 / 2
            } else {
                money = money * 5 / 4
            }
        } else { // to USD
            let curr = self.currency
            if (curr == "GBP") {
                money = money * 2
            } else if (curr == "EUR") {
                money = money * 2 / 3
            } else {
                money = money * 4 / 5
            }
        }
        return Money(amount: money, currency: to)
    }
    
    
    public func add(_ to: Money) -> Money {
        var toAmount = Money(amount: self.amount, currency: self.currency)
        if (self.currency != to.currency) {
            toAmount = self.convert(to.currency)
        }
        return Money(amount: toAmount.amount + to.amount, currency: toAmount.currency)
    }
    
    public func subtract(_ from: Money) -> Money {
        var fromAmount = Money(amount: self.amount, currency: self.currency)
        if (self.currency != from.currency) {
            fromAmount = self.convert(from.currency)
        }
        return Money(amount: fromAmount.amount - from.amount, currency: fromAmount.currency)
    }
}

// Extension
extension Double {
    var USD: Money {return Money(amount: Int(self), currency: "USD")}
    var EUR: Money {return Money(amount: Int(self), currency: "EUR")}
    var GBP: Money {return Money(amount: Int(self), currency: "GBP")}
    var YEN: Money {return Money(amount: Int(self), currency: "YEN")}
}

////////////////////////////////////
// Job
//
open class Job : CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType
    
    var description: String {
        return ("Works at \(title) and gets paid \(calculateIncome(10))")
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(var pay) :
            return Int(pay * Double(hours))
        case .Salary(var salary) :
            return salary
        default :
            return 0
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(var pay) :
            self.type = JobType.Hourly(pay + amt)
        case .Salary(var salary) :
            self.type = JobType.Salary(salary + Int(amt))
        default :
            print("Nothing happened")
        }
    }
}

////////////////////////////////////
// Person
//
open class Person : CustomStringConvertible {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    var description : String {
        var job = ""
        var spouse = ""
        if (self._job != nil) {
            job = "\(self._job)"
        } else {
            job = "no job"
        }
        if (self._spouse != nil) {
            spouse = "\(self._spouse)"
        } else {
            spouse = "not married"
        }
        return ("\(firstName) \(lastName): {job: \(job) | spouse: \(spouse)}")
    }
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return _job}
        set(value) {
            if (self.age >= 16) {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return _spouse}
        set(value) {
            if (self.age >= 18) {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible {
    fileprivate var members : [Person] = []
    
    var description: String {
        var family = "Family: \n"
        for i in 0...members.count {
            family += "\(members[i].description)\n"
        }
        return family
    }
    
    public init(spouse1: Person, spouse2: Person) {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        self.members.append(spouse1)
        self.members.append(spouse2)
    }
    
    open func haveChild(_ child: Person) -> Bool {
        self.members.append(child)
        return true
    }
    
    open func householdIncome() -> Int {
        var income = 0
        for person in self.members {
            if (person.job != nil) {
                income += (person.job?.calculateIncome(2000))!
            }
        }
        return income
    }
}
 






