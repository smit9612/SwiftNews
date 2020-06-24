//
//  NewsDetailsViewController.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-23.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit
import RxSwift

import Nuke

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    
    let disposeBag = DisposeBag()
    var viewModel: NewsDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //title = viewModel.title
//        textLabel.text = viewModel.displayText
//        textLabel.sizeToFit()
//        if let imageURL = viewModel.imageURL {
//            imageContainerView.isHidden = false
//            Nuke.loadImage(with: imageURL, into: detailImage)
//
//        } else {
//            imageContainerView.isHidden = true
//        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - View Methods

       private func setupView() {
           bindViewModel()
       }

       func bindViewModel() {
        viewModel.title
        .drive(self.rx.title)
        .disposed(by: disposeBag)
        
        
        viewModel.displaytext
               .drive(textLabel.rx.text)
               .disposed(by: disposeBag)

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
