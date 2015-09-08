//
//  simpleAppTests.swift
//  simpleAppTests
//
//  Created by Venkatasubramanian, Shriram on 9/6/15.
//  Copyright (c) 2015 Venkatasubramanian, Shriram. All rights reserved.
//

import UIKit
import XCTest

class simpleAppTests: XCTestCase {
    
   
    var productCheck:NSDictionary = NSDictionary();
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForProductDetails() {
        
        var check: NSArray = self.loadProducts()
       
        XCTAssertNotNil(check, "value retrived from web page...")

    }
    
    func loadProducts()-> NSArray {
            var jsonObjectCheck: NSArray = NSArray();
            var url : String = "http://ebay.0x10.info/api/ebay?type=json&query=list_product"
            var request : NSMutableURLRequest = NSMutableURLRequest()
            request.URL = NSURL(string: url)
            request.HTTPMethod = "GET"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
                
                if (jsonResult != nil) {
                    jsonObjectCheck = jsonResult["product"] as! NSArray
                } else {
                    // couldn't load JSON, look at error
                }
    
            })
            return jsonObjectCheck
        }
    
    func testForAPIhits(){
        
        var check: NSArray = self.loadAPIHits()
        
        XCTAssertNotNil(check, "value retrived from web page...")
        

    }
    
    func loadAPIHits() -> NSArray {
        var APIHits: NSArray = NSArray();
    var url : String = "http://ebay.0x10.info/api/ebay?type=json&query=api_hits"
    var request : NSMutableURLRequest = NSMutableURLRequest()
    request.URL = NSURL(string: url)
    request.HTTPMethod = "GET"
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
    var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
    let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
    
    if (jsonResult != nil) {
        var APIHits = jsonResult["api_hits"] as! String
    } else {
    // couldn't load JSON, look at error
    }
    })
   return APIHits
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            self.loadProducts()
            // Put the code you want to measure the time of here.
        }
    }
}