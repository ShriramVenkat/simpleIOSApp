# simpleIOSApp

###ios-ebay-challenge-app 
A swift project.  

###Requirements 
iOS 7.0+ / Mac OS X 10.9+ 
Xcode 6.3  

###Instructions 
Load the application into XCODE 
Build &amp; run using XCODE  

###Source-Code 
Ebay/mainViewController.swift 
Ebay/productDetailsView.swift  

###Unit-Test 
Unit-Tests for all the controllers can be found in simpleAppTests/simpleAppTests.swift  

###Snapshots Of the working application
simpleIOSApp/screenshots
    ##Loading.png :
        Snapshot of the loading screen. Displayed while the application is initializing
    ##Home-Page.png :
        Snapshot of the working home-page
            Index of all the products are displayed.
            Clicking on a product will take you to Details page with that particular product detail
            Sort by name & price are enabled on these product indexes
            ApI hits is populated from the service provided (http://ebay.0x10.info/api/ebay?type=json&query=api_hits)
    ##Home-Sorted.png :
        Snapshot of the Home-Page after sorting by name(or clicking on name button in the home page)
    ##Details.png
        Snapshot of the details page. This page is displayed on clicking any product from the home page
            All the product details are populated from the provided service (http://ebay.0x10.info/api/ebay?type=json&query=list_product)

###Author 
Shriram Venkatasubramanian

