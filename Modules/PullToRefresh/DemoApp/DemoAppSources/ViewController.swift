//
//  ViewController.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import Combine
import UIKit

import PullToRefresh
import SharedResources
import SnapKit

final class ViewController: UIViewController {
    enum Constants {
        static let topPadding = 50.0
        static let cellID = "cell"
        static let tableViewContentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: -topPadding, right: 0)
    }
    
    private let viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let customRefreshControl: CustomRefreshControl = {
        let refreshControl = CustomRefreshControl(topPadding: Constants.topPadding)
        return refreshControl
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .gray100
        tableView.separatorStyle = .none
        tableView.contentInset = Constants.tableViewContentInset
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupTableView()
        setupAction()
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
        tableView.refreshControl = customRefreshControl
        customRefreshControl.observe(scrollView: tableView)
    }
    
    private func setupAction() {
        customRefreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    private func bindViewModel() {
        viewModel.shouldEndRefreshing
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.customRefreshControl.endRefreshing()
                self?.viewModel.resetPullToRefreshSubjects()
            }
            .store(in: &cancellables)
        
        viewModel.$data
            .receive(on: DispatchQueue.main)
            .map { array -> Bool in
                return array.isEmpty
            }
            .sink { [weak self] bool in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc func handleRefresh() {
        customRefreshControl.beginRefreshing()
        viewModel.refreshData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let color = viewModel.data[indexPath.section]
        cell.backgroundColor = color
        cell.selectionStyle = .none
        cell.accessibilityIdentifier = Constants.cellID + "\(indexPath.section)"
        cell.accessibilityLabel = color.accessibilityDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        customRefreshControl.resetRefreshControl()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        viewModel.didEndDraggingSubject.send(true)
    }
}
