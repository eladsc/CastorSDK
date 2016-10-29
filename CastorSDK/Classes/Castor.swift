//
//  Castor.swift
//  Pods
//
//  Created by elad schiller on 22/10/2016.
//
//

import UIKit
///This object is a singlton that manages the Castor Store.
public class Castor {
///The singlton instance you should use for all actions.
 public static let manager = Castor()
  
  /// The  products available for sale. The key is the ID of the product and the value is the Product object.
 public private(set) var products : [String: Product] = [:]
  
  public var productsArray : [Product] {
    get{
    return Array(products.values)
    }
  }
  //private variables
  
  //This variable tells wether the SDK was already confiured successfully or not
  private var configured = false
  
  ///An array of available products
 public func configure(key: String){
    if configured {
    return
    }
    //decoding from a base 64 string to an array of Products
    let decodedData = NSData(base64Encoded: key, options: NSData.Base64DecodingOptions(rawValue: 0))
    do{
    let jsonArr = try JSONSerialization.jsonObject(with: decodedData as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
      
      for  dicObject  in jsonArr {
        if let dic = dicObject as? NSDictionary {
         if let product = Product(dictionary: dic){
          products[product.id] = product
          }
        }
      }
      
     configured = true
    } catch  let error as NSError {
      // failure
      print("Fetch failed: \(error.localizedDescription)")
    }
  }
  
  
  }
