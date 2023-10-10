//
//  ViewController.swift
//  POLZZAK
//
//  Created by POLZZAK_iOS.
//

import Combine
import UIKit

import SwipeToDelete

final class ViewController: UIViewController {
    private var data: [UIColor] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: SwipeTableViewCell.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        setupTableView()
    }
}

extension ViewController {
    private func setupUI() {
        view.backgroundColor = .white
        
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
    
    private func setupData() {
        for _ in 0...19 {
            data.append(UIColor.random)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwipeTableViewCell.reuseIdentifier, for: indexPath) as! SwipeTableViewCell
        let color = data[indexPath.section]
        cell.swipeableDelegate = self
        cell.configure(color: color)
        cell.selectionStyle = .none
        cell.accessibilityIdentifier = "\(indexPath.section)"
        cell.deleteButton.accessibilityIdentifier = "\(indexPath.section)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension ViewController: SwipeableTableViewCellDelegate {
    func didTapDeleteButton(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        data.remove(at: indexPath.section)
        tableView.deleteSections([indexPath.section], with: .fade)
    }
}
