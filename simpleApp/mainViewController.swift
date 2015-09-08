//
//  mainViewController.swift
//  Ebay
//
//  Created by Venkatasubramanian, Shriram on 9/6/15.
//  Copyright (c) 2015 Venkatasubramanian, Shriram. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    var allProducts: NSArray = NSArray();
    var APIHits: String = String();
    
    @IBOutlet weak var loadingView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.borderWidth = 2.0
        self.view.layer.cornerRadius = 8
        
        if(self.allProducts.count == 0) {
            loadProducts()
        }
        else {
            addProductsToView(self.allProducts)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //to draw stuff on screen and show self.allProducts
    
    func addProductToView(product:NSDictionary, rowCount:Int) -> Void {
        
        let scrnHeight = self.view.frame.size.height
        let scrnWidth = self.view.frame.size.width;
    
        let yHeight = 0.05 * scrnHeight
        let yInitOffset = 0.14 * scrnHeight;
        let yOffset = yInitOffset + (yHeight + 0.01 * scrnHeight) * CGFloat(rowCount)
        
        let nameWidth = 0.6 * scrnWidth
        let prcWidth = 0.2 * scrnWidth
        let btnWidth = 0.1 * scrnWidth
        
        var btn: UIButton = UIButton()
        btn.frame=CGRectMake(0.02 * scrnWidth, yOffset, 0.96 * scrnWidth, yHeight)

        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.blackColor().CGColor
        btn.layer.cornerRadius = 7
        let btnName = product["name"] as! String
        btn.setTitle(">", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        btn.addTarget(self, action: "showProductDetails:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.tag = rowCount
        self.view.addSubview(btn)
        
        var label: UILabel = UILabel();
        label.frame = CGRectMake(0.02 * scrnWidth, yOffset, nameWidth, yHeight)
        label.backgroundColor=UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = product["name"] as?String
        label.font = UIFont(name: label.font.fontName, size: 15)

        self.view.addSubview(label)
        
        
        var prc_label: UILabel = UILabel();
        prc_label.frame = CGRectMake(0.02 * scrnWidth + nameWidth, yOffset, prcWidth, yHeight)
        prc_label.backgroundColor=UIColor.clearColor()
        prc_label.text = product["price"] as? String

        self.view.addSubview(prc_label)
        
        }
 
    //display APIHits on screen
    
    func addAPIHitsToView()-> Void {
        let scrnHeight = self.view.frame.size.height
        let scrnWidth = self.view.frame.size.width
        var label: UILabel = UILabel();
        label.frame = CGRectMake(scrnWidth/2.0, scrnHeight*0.85, scrnWidth/2.0, 0.1*scrnHeight)
        label.textAlignment = NSTextAlignment.Center
        label.text = "API Hits: " + self.APIHits
        self.view.addSubview(label);
    }
    
    //display the product count
    
    func addProductCountToView(productCount:Int)-> Void {
        let scrnHeight = self.view.frame.size.height
        let scrnWidth = self.view.frame.size.width
        var label: UILabel = UILabel();
        label.frame = CGRectMake(0, scrnHeight*0.85, scrnWidth/2.0, 0.1*scrnHeight)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Total Products: " + String(productCount)
        self.view.addSubview(label);
    }
    
    //make REST call and load all products into self.allProducts
    
    func loadProducts()-> Void {
        var url : String = "http://ebay.0x10.info/api/ebay?type=json&query=list_product"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
                self.allProducts = jsonResult["product"] as! NSArray
                            } else {
            }
            self.loadingView.hidden = true
            self.addProductsToView(self.allProducts);
        })
    }
    
    //iterate over all prducts and call addProductToView
    
    func addProductsToView(productObject: NSArray) -> Void {
        
        let scrnHeight = self.view.frame.size.height
        let scrnWidth = self.view.frame.size.width;
        let imageName = "ebay.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 1, y: 1, width: scrnWidth/2, height: scrnHeight * 0.15)
        view.addSubview(imageView)

        var viewTitle:UILabel = UILabel();
        viewTitle.frame = CGRectMake(scrnWidth*0.5, scrnHeight*0.05, scrnWidth*0.45, scrnHeight*0.07)
        viewTitle.backgroundColor=UIColor.clearColor()
        viewTitle.layer.borderWidth = 1.0
        viewTitle.textAlignment = NSTextAlignment.Center
        viewTitle.numberOfLines = 0
        viewTitle.text = "HOME"
        viewTitle.font = UIFont(name: viewTitle.font.fontName, size: 20)
        self.view.addSubview(viewTitle)

        var rowCount = 0
        for product in productObject {
            self.addProductToView(product as! NSDictionary, rowCount:rowCount)
            rowCount++
        }
        self.addProductCountToView(self.allProducts.count)
        loadAPIHits()
    }
    
    //display sort buttons on screen
    
    func loadSortButton() -> Void{
        
        let scrnHeight = self.view.frame.size.height
        let scrnWidth = self.view.frame.size.width
        
        var sortIcon: UILabel = UILabel();
        sortIcon.frame = CGRectMake(0.01 * scrnWidth, 0.94 * scrnHeight, 0.1 * scrnWidth, 0.05 * scrnHeight)
        sortIcon.backgroundColor=UIColor.clearColor()
        sortIcon.textAlignment = NSTextAlignment.Center
        sortIcon.text = "sort: "
        sortIcon.font = UIFont(name: sortIcon.font.fontName, size: 15)
        self.view.addSubview(sortIcon)
        
        var sortNamebtn: UIButton = UIButton()
        sortNamebtn.frame=CGRectMake(0.15 * scrnWidth, 0.95 * scrnHeight, 0.18 * scrnWidth, 0.04 * scrnHeight)
        sortNamebtn.layer.borderWidth = 1.0
        sortNamebtn.layer.borderColor = UIColor.blackColor().CGColor
        sortNamebtn.layer.cornerRadius = 7
        sortNamebtn.setTitle("name", forState: UIControlState.Normal)
        let btnName = "Sort By Name Button"
        sortNamebtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sortNamebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        sortNamebtn.addTarget(self, action: "showSortedProductsByName:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(sortNamebtn)
        
        var sortPricebtn: UIButton = UIButton()
        sortPricebtn.frame=CGRectMake(0.4 * scrnWidth, 0.95 * scrnHeight, 0.18 * scrnWidth, 0.04 * scrnHeight)
        sortPricebtn.layer.borderWidth = 1.0
        sortPricebtn.layer.borderColor = UIColor.blackColor().CGColor
        sortPricebtn.layer.cornerRadius = 7
        sortPricebtn.setTitle(" price", forState: UIControlState.Normal)
        sortPricebtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sortPricebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        sortPricebtn.addTarget(self, action: "showSortedProductsByPrice:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(sortPricebtn)
        
    }
    
    //make REST call and load APIHits into self.APIHits
    
    func loadAPIHits() -> Void {
        var url : String = "http://ebay.0x10.info/api/ebay?type=json&query=api_hits"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
                self.APIHits = jsonResult["api_hits"] as! String
            } else {
                self.view.removeFromSuperview()
                self.APIHits = "json-error"
            }
            self.addAPIHitsToView();
        })
        loadSortButton()
    }
    
    //navigates to productDetails screen
    
    func showProductDetails(sender:UIButton!) -> Void {
        let newView:productDetailsView = productDetailsView()
        newView.productDetails = self.allProducts[sender.tag] as! NSDictionary
        self.presentViewController(newView, animated:true, completion:nil)
    }

    //will sortProducts by their name and display
    
    func showSortedProductsByName(sender:UIButton!) -> Void {
        self.allProducts = self.allProducts.sortedArrayUsingDescriptors([NSSortDescriptor(key: "name", ascending: true)])
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        addProductsToView(self.allProducts)
    }
    
    //will sortProducts by their price and display
    
    func showSortedProductsByPrice(sender:UIButton!) -> Void {
        var sortedResults: NSArray = self.allProducts.sortedArrayUsingDescriptors([NSSortDescriptor(key: "price", ascending: true)])
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        addProductsToView(sortedResults)
    }
}
