//
//  ArtNetAppProducts.swift
//  uni-converter
//
//  Created by Maegan Wilson on 9/10/19.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation

public struct ArtnetAppProducts {
    
    public static let coffee = "tier3"
    public static let heart = "tier2"
    public static let hundred = "tier4"
    public static let smile = "tier1"
    
    private static let productIdentifiers: Set<ProductIdentifier> = [ArtnetAppProducts.smile, ArtnetAppProducts.heart, ArtnetAppProducts.coffee, ArtnetAppProducts.hundred]
    
    public static let store = IAPHelper(productIds: ArtnetAppProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}
