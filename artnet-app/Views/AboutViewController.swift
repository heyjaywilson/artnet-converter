//
//  AboutViewController.swift
//  artnet-app
//
//  Created by Maegan Wilson on 7/7/18.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit
import StoreKit

class AboutViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var getSupportButton: UIButton!
    @IBOutlet weak var tipping: UILabel!
    
    @IBOutlet weak var tipTableView: UITableView!
    
    var about: String = "This app is created by Maegan. Maegan appreciates you downloading and using the app. The app does not require the input of any personal data nor does it go through your phone to sell personal data."
    
    var issue: String = "Ran into issues while using the app? Click the button to get support from Maegan."
    
    var tippingString: String = "Enjoyed using the app? Please consider giving a tip to show your support."
    
    var products: [SKProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        aboutLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        aboutLabel.numberOfLines = 0
        aboutLabel.text = about
        
        issueLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        issueLabel.numberOfLines = 0
        issueLabel.text = issue
        
        tipping.lineBreakMode = NSLineBreakMode.byWordWrapping
        tipping.numberOfLines = 0
        tipping.text = tippingString
        
        tipTableView.delegate = self
        tipTableView.dataSource = self
        
        tipTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //getSupportButton.addTarget(self, action: "didTapGetSupport", forControlEvents: .TouchUpInside)
        
        ArtnetAppProducts.store.requestProducts { (success, products) in
            if success {
                self.products = products!
                self.tipTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath) as? ProductCell
        let product = self.products[indexPath.row]
        
        cell?.product = product
        cell?.buyButtonHandler = { product in
            ArtnetAppProducts.store.buyProduct(product)
        }
        
        return cell!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didTapGetSupport(_ sender: UIButton) {
        let website = URL(string: "https://fixture-uni-converter.maeganwilson.com")
        UIApplication.shared.open(website!)
    }
    
}
