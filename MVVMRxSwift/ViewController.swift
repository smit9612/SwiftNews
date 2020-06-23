//
//  ViewController.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableviewController: UITableView!
    let disposeBag = DisposeBag()
    var viewModel: NewsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        tableviewController.contentInsetAdjustmentBehavior = .never
        // Do any additional setup after loading the view.
        tableviewController.tableFooterView = UIView()
        fetchResaurants()
    }

    
    private func fetchResaurants() {
        
        viewModel.fetchNewListViewModel().observeOn(MainScheduler.instance).bind(to:
        tableviewController.rx.items(cellIdentifier: "cell")) { index, viewModel, cell in
            cell.textLabel?.text = viewModel.displayText
        }.disposed(by: disposeBag)
    }
}

