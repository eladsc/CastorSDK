//
//  ProductTableViewCell.swift
//  CastorSDK
//
//  Created by elad schiller on 22/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import CastorSDK
class ProductTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var idLabel: UILabel!
  var product: Product?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  func setupCell(product: Product){
  nameLabel.text = product.name
    idLabel.text = "ID: " + product.id
  }

}
