//
//  ProductCellTableViewCell.swift
//  artnet-app
//
//  Created by Maegan Wilson on 8/5/18.
//  Copyright © 2018 MW. All rights reserved.
//
import UIKit
import StoreKit

class ProductCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textLabel?.text = product?.localizedTitle
        detailTextLabel?.text = product?.localizedDescription
    }
    
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var buyButtonHandler: ((_ product: SKProduct) -> Void)?
    
    var product: SKProduct? {
        didSet {
            guard let product = product else { return }
            
            //textLabel?.text = product.localizedTitle
            //print(product)
            
            switch product.localizedTitle {
            case "smile":
                textLabel?.text = "😊"
            case "coffee":
                textLabel?.text="☕"
            case "heart":
                textLabel?.text="❤️"
            case "100":
                textLabel?.text="💯"
            default:
                textLabel?.text = product.localizedTitle
            }
            if IAPHelper.canMakePayments() {
                ProductCell.priceFormatter.locale = product.priceLocale
                detailTextLabel?.text = product.localizedDescription
                
                accessoryType = .none
                accessoryView = self.newBuyButton(price: ProductCell.priceFormatter.string(from: product.price)!)
            } else {
                detailTextLabel?.text = "Not available"
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = ""
        detailTextLabel?.text = ""
        accessoryView = nil
    }
    
    func newBuyButton(price: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(tintColor, for: .normal)
        button.setTitle("Tip \(price)", for: .normal)
        button.addTarget(self, action: #selector(ProductCell.buyButtonTapped(_:)), for: .touchUpInside)
        button.sizeToFit()
        
        return button
    }
    
    @objc func buyButtonTapped(_ sender: AnyObject) {
        buyButtonHandler?(product!)
    }
}
