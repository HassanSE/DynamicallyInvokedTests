//
//  DynamicallyInvokedTests.swift
//  DynamicallyInvokeTestsTests
//
//  Created by Muhammad Hassan on 31/10/2020.
//

import XCTest

class FullNamesGeneratorTests: XCTestCase {
    
    var names = [String]()
    var expectedFullName = ""
    
    override class var defaultTestSuite: XCTestSuite {
        let testSuite = XCTestSuite(forTestCaseClass: FullNamesGeneratorTests.self)
        
        let bundle = Bundle(for: FullNamesGeneratorTests.self)
        let path = bundle.url(forResource: "names", withExtension: "json")
        let json = try! Data(contentsOf: path!, options: .mappedIfSafe)
        let jsonArray = try! JSONDecoder().decode([[String: String]].self, from: json)
        
        for names in jsonArray {
            addNewTest(withNames: [names["firstName"]!, names["lastName"]!], expectedResult: names["fullName"]!, testSuite: testSuite)
        }
        
        return testSuite
    }
    
    class func addNewTest(withNames names: [String],
                          expectedResult: String,
                          testSuite: XCTestSuite) {
        for invocation in self.testInvocations {
            let newTestCase = FullNamesGeneratorTests(invocation: invocation)
            newTestCase.names = names
            newTestCase.expectedFullName = expectedResult
            testSuite.addTest(newTestCase)
        }
    }
    
    func test_full_name_generator() {
        var fullName = ""
        for name in names {
            fullName += name
            if name != names.last {
                fullName += " "
            }
        }
        XCTAssertEqual(fullName, expectedFullName)
    }
}
