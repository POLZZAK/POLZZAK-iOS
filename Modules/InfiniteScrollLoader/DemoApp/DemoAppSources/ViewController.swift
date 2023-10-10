//
//  ViewController.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import Combine
import UIKit

import SnapKit
import InfiniteScrollLoader

final class ViewController: UIViewController, InfiniteScrolling {
    typealias InfiniteScrollingViewModelType = ViewModel
    var viewModel: ViewModel = ViewModel()
    
    enum Constants {
        static let cellID = "cell"
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupTableView()
        bindViewModel()
    }
}

extension ViewController {
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.$data
            .receive(on: DispatchQueue.main)
            .sink { [weak self] bool in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath)
        let color = viewModel.data[indexPath.section]
        cell.backgroundColor = color
        cell.selectionStyle = .none
        cell.accessibilityIdentifier = Constants.cellID + "\(indexPath.section)"
        cell.accessibilityLabel = color.accessibilityDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel.resetBottomRefreshSubjects()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDidReachEnd(scrollView)
    }
}
