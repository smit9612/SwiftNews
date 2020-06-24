//
//  NewsDetailsViewController.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit
import Nuke

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    @IBOutlet weak var imageContainerView: UIView!
    var newsViewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = newsViewModel.title
        textLabel.text = newsViewModel.displayText
        textLabel.sizeToFit()
        if let imageURL = newsViewModel.imageURL {
            imageContainerView.isHidden = false
            Nuke.loadImage(with: imageURL, into: detailImage)

        } else {
            imageContainerView.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
