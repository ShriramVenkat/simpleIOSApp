//
//  productDetailsView.swift
//  Ebay
//
//  Created by Venkatasubramanian, Shriram on 9/6/15.
//  Copyright (c) 2015 Venkatasubramanian, Shriram. All rights reserved.
//

import UIKit

class productDetailsView: UIViewController {
    
    var productDetails:NSDictionary = NSDictionary();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.borderWidth = 2.0
        self.view.layer.cornerRadius = 8
        createView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //display all details of the product, acts as a base function
    
    func createView() -> Void {
        
        let scrnHeight = self.view.frame.size.height
        let scrnWidth = self.view.frame.size.width;
        self.view.backgroundColor = UIColor.whiteColor()
       
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
        viewTitle.text = "Details"
        viewTitle.font = UIFont(name: viewTitle.font.fontName, size: 20)
        self.view.addSubview(viewTitle)

        addDetailsToView("Name.png",txt: self.productDetails["name"] as! String,                           x: 0.20, y: 0.15, width: 0.75, height: 0.1)
        addDetailsToView("Cart.png",txt: self.productDetails["category"] as! String,                       x: 0.20, y: 0.25, width: 0.30, height: 0.1)
        addDetailsToView("price.gif", txt: (self.productDetails["price"] as? String ?? ""),                x: 0.65, y: 0.25, width: 0.30, height: 0.1)
        addDetailsToView("location.png",txt: self.productDetails["location"] as! String,                   x: 0.20, y: 0.30, width: 0.30, height: 0.1)
        addDetailsToView("quantity.png",txt: (self.productDetails["quantity"] as? String ?? ""),           x: 0.65, y: 0.30, width: 0.30, height: 0.1)
        addDetailsToView("shipping.png",txt: (self.productDetails["shipping"] as? String ?? ""),           x: 0.20, y: 0.35, width: 0.30, height: 0.1)
        addDetailsToView("Color.png",txt: self.productDetails["color"] as! String,                         x: 0.65, y: 0.35, width: 0.30, height: 0.1)
        
        var description:UILabel = UILabel();
        description.frame = CGRectMake(5.0, scrnHeight/2, 0.97 * scrnWidth, 0.4 * scrnHeight)
        description.backgroundColor=UIColor.whiteColor()
        description.layer.borderWidth = 1.3
        description.layer.borderColor = UIColor.blackColor().CGColor
        description.layer.cornerRadius = 7
        description.textAlignment = NSTextAlignment.Center
        description.numberOfLines = 0
        description.text = "Description:\n" + (self.productDetails["description"] as? String ?? "")
        description.font = UIFont(name: description.font.fontName, size: 15)
        self.view.addSubview(description)
        
        var backButton:UIButton = UIButton();
        let borderAlpha : CGFloat = 0.7
        backButton.frame=CGRectMake(0, 0.93*scrnHeight, 0.35*scrnWidth, 0.05*scrnHeight)
        backButton.backgroundColor=UIColor.lightGrayColor()
        backButton.layer.borderWidth = 1.0
        backButton.layer.borderColor = UIColor.blackColor().CGColor
        backButton.layer.cornerRadius = 7
        backButton.setTitle("<<Back", forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backButton)
    }
    
    //display details of the product
    
    func addDetailsToView(icon: String, txt: String, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) -> Void{
        
        let scrnHeight = self.view.frame.size.height
        let scrnWidth = self.view.frame.size.width;
        
        let imageName = icon
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)

        imageView.frame = CGRect(x: (scrnWidth * (x - 0.07)), y: (scrnHeight * (y + 0.03)), width: 15, height: 15)
        view.addSubview(imageView)

        var itemDetails:UILabel = UILabel();
        itemDetails.frame = CGRectMake(x * scrnWidth, y * scrnHeight, width * scrnWidth, height * scrnHeight)
        itemDetails.textAlignment = NSTextAlignment.Left
        itemDetails.numberOfLines = 0
        itemDetails.text = txt
        itemDetails.font = UIFont(name: itemDetails.font.fontName, size: 14)
        self.view.addSubview(itemDetails)
        
    }
    
    //back button action handler
    
    func back(sender:UIButton!) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil);
    }

}
