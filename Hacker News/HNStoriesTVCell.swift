//
//  HNStoriesTVC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import Skeleton

class HNStoriesTVCell: UITableViewCell {
    @IBOutlet weak var imagePlaceholderView: UIView!
    @IBOutlet weak var titlePlaceholderView: GradientContainerView!
    @IBOutlet weak var subtitlePlaceholderView: GradientContainerView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        imagePlaceholderView.layer.cornerRadius = imagePlaceholderView.bounds.width/2
    }
}

extension HNStoriesTVCell: GradientsOwner {
    var gradientLayers: [CAGradientLayer] {
        return [titlePlaceholderView.gradientLayer, subtitlePlaceholderView.gradientLayer]
    }
}
