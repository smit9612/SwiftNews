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
    }
    
    // MARK: - View Methods

       private func setupView() {
           bindViewModel()
       }

       func bindViewModel() {
        viewModel.title
                   .observeOn(MainScheduler.instance)
                   .bind(to: self.rx.title)
                   .disposed(by: disposeBag)
  
        viewModel.displaytext
            .observeOn(MainScheduler.instance)
            .bind(to: textLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.loadImage()
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                self?.detailImage.alpha = 0
                UIView.animate(withDuration: 0.25) {
                    self?.detailImage.alpha = 1.0
                }
            })
            .bind(to: detailImage.rx.image)
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
