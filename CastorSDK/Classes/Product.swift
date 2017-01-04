//
//  3DModel.swift
//  Pods
//
//  Created by elad schiller on 21/10/2016.
//
//

import UIKit
///An object reprisenting a 3D model available for sale on the Castor store.
@objc public class Product : NSObject{
///The unique identifier of the model
  public let id : String
  ///The name of the model
  public let name: String
 
  
  //The url to the wix site
  internal  let url: URL
  
  
  internal init?(dictionary: NSDictionary){
    do {

  id = String( describing: dictionary["id"] as! NSNumber )
    let urlStr = dictionary["url"]!
    url = URL(string: urlStr as! String)!
      name = dictionary["name"]! as! String
    } catch let error as NSError{
    return nil
    }
    
}
}
