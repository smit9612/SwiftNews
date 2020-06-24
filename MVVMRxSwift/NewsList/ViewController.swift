//
//  ViewController.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Nuke

class ViewController: UIViewController {

    @IBOutlet var tableview: UITableView!
    let disposeBag = DisposeBag()
    var viewModel: NewsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.tableFooterView = UIView()

        setupBindings()
    }

    private func setupBindings() {
        viewModel.fetchNewListViewModel().observeOn(MainScheduler.instance).bind(to:
            tableview.rx.items(cellIdentifier: "NewsCell", cellType: NewsCell.self)) { _, viewModel, cell in
            cell.newsTitle.text = viewModel.title
            // show loading
            if let thumb = viewModel.imageURL {
                Nuke.loadImage(with: thumb, into: cell.heroImage)
            }
                
           
    }.disposed(by: disposeBag)
        

        tableview.rx.modelSelected(NewsViewModel.self).subscribe(onNext: { item in
            self.showDetailsView(with: item)
        }).disposed(by: disposeBag)

//        tableview.rx.modelSelected(NewsViewModel.self)
//            .bind(to: viewModel.selectedNews)
//                   .disposed(by: disposeBag)
    }
    
    func showDetailsView(with news: NewsViewModel) {
        let detailsViewController: NewsDetailsViewController = UIStoryboard(storyboard: .main).instatiateViewController()
        
        // set view model
        detailsViewController.newsViewModel = news
        navigationController?.pushViewController(detailsViewController, animated: true)

    }
}
