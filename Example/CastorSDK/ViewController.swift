//
//  ViewController.swift
//  CastorSDK
//
//  Created by elad schiller on 10/21/2016.
//  Copyright (c) 2016 elad schiller. All rights reserved.
//

import UIKit
import CastorSDK
class ViewController: UIViewController {

  @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDataSource{
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
  return Castor.manager.productsArray.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell:ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ProductTableViewCell
    let product = Castor.manager.productsArray[indexPath.row]
    cell.setupCell(product: product )
    
    return cell
  }
}

extension ViewController : UITableViewDelegate{

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let product = Castor.manager.productsArray[indexPath.row]
    
    let controller = StoreViewController.makeStoreViewController(product: product, delegate: self)
    present(controller, animated: true, completion: nil)
    
  }
}

  
  extension ViewController : StoreViewControllerDelegate{
    
    func complete( viewController: StoreViewController , status: CompletionStatus){
    viewController.dismiss(animated: true, completion: nil)
  }
  
}

