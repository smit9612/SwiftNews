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

class ViewController: UIViewController {

    @IBOutlet var tableview: UITableView!
    let disposeBag = DisposeBag()
    var viewModel: NewsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        tableview.contentInsetAdjustmentBehavior = .never
        // Do any additional setup after loading the view.
        tableview.tableFooterView = UIView()
        fetchResaurants()
    }

    private func fetchResaurants() {
        viewModel.fetchNewListViewModel().observeOn(MainScheduler.instance).bind(to:
            tableview.rx.items(cellIdentifier: "NewsCell", cellType: NewsCell.self)) { _, viewModel, cell in
            print(viewModel.displayText)
            cell.newsTitle.text = viewModel.displayText
            // show loading
            if let thumb = viewModel.imageURL {
                cell.heroImage?.loadImage(url: URL(string: thumb)!)
            }
        }.disposed(by: disposeBag)

        tableview.rx.modelSelected(NewsViewModel.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.displayText)")
        }).disposed(by: disposeBag)
    }
}
