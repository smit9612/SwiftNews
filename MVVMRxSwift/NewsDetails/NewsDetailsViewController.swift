//
//  NewsDetailsViewController.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    var newsViewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = newsViewModel.displayText
        
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
