//
//  NotificationViewController.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/07/11.
//

import Combine
import UIKit

import InfiniteScrollLoader
import Loading
import PullToRefresh
import SnapKit
import SwipeToDelete
import Toast

final class NotificationViewController: UIViewController, InfiniteScrolling {
    typealias InfiniteScrollingViewModelType = NotificationViewModel
    var viewModel: NotificationViewModel = NotificationViewModel(repository: NotificationDataRepository())
    
    enum Constants {
        static let topPadding = 16.0
        static let tableViewContentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: topPadding, right: 0)
    }
    
    private var lastContentOffset: CGFloat = 0
    private var isScrollingUp: Bool = false
    
    private var toast: Toast?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let notificationSkeletonView = NotificationSkeletonView()
    private let fullLoadingView = FullLoadingView()
    
    private let customRefreshControl: CustomRefreshControl = {
        let refreshControl = CustomRefreshControl(topPadding: Constants.topPadding)
        return refreshControl
    }()
    
    private let contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.reuseIdentifier)
        tableView.contentInset = Constants.tableViewContentInset
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .gray100
        tableView.separatorStyle = .none
        
        customRefreshControl.observe(scrollView: tableView)
        tableView.refreshControl = customRefreshControl
        return tableView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.setLabel(text: "알림이 없어요", textColor: .gray400, font: .subtitle20Rg)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigation()
        setupTableView()
        setupAction()
        bindViewModel()
    }
}

extension NotificationViewController {
    private func setupUI() {
        view.backgroundColor = .white
        
        [contentsView, fullLoadingView].forEach {
            view.addSubview($0)
        }
        
        contentsView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        fullLoadingView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        [tableView, emptyLabel, notificationSkeletonView].forEach {
            contentsView.addSubview($0)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        notificationSkeletonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupNavigation() {
        title = "알림"
        
        navigationController?.navigationBar.tintColor = .gray800
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let rightButtonImage = UIImage.notificationSettingButton
        let rightButton = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(notificationSetting))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func notificationSetting() {
        let notificationSettingViewController = NotificationSettingViewController(viewModel: viewModel)
        notificationSettingViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(notificationSettingViewController, animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupAction() {
        customRefreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    private func bindViewModel() {
        viewModel.shouldEndRefreshing
            .receive(on: DispatchQueue.main)
            .sink { [weak self] bool in
                self?.customRefreshControl.endRefreshing()
                self?.viewModel.resetPullToRefreshSubjects()
            }
            .store(in: &cancellables)
        
        viewModel.isSkeleton
            .receive(on: DispatchQueue.main)
            .sink { [weak self] bool in
                self?.handleSkeletonView(for: bool)
            }
            .store(in: &cancellables)
        
        viewModel.isCenterLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] bool in
                self?.handleLoadingView(for: bool)
            }
            .store(in: &cancellables)
        
        viewModel.$notificationList
            .receive(on: DispatchQueue.main)
            .map { array -> Bool in
                return array.isEmpty
            }
            .sink { [weak self] bool in
                self?.tableView.reloadData()
                self?.handleEmptyView(for: bool)
            }
            .store(in: &cancellables)
        
        viewModel.showErrorAlertSubject
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { _ in
                let error = PolzzakError.userError.description
                Toast(type: .error(error)).show()
            }
            .store(in: &cancellables)
    }
    
    private func handleSkeletonView(for bool: Bool) {
        if true == bool {
            viewModel.fetchNotificationList(isFirst: true, more: false)
            notificationSkeletonView.showSkeletonView()
        } else {
            notificationSkeletonView.hideSkeletonView()
        }
    }
    
    private func handleLoadingView(for bool: Bool) {
        if true == bool {
            fullLoadingView.startLoading()
        } else {
            fullLoadingView.stopLoading()
        }
    }
    
    private func handleEmptyView(for bool: Bool) {
        emptyLabel.isHidden = !bool
    }
    
    private func moveToTabBar(linkType: NotificationLink) {
        guard let topVC = UIApplication.getTopViewController() else { return }
        guard let tabBarController = topVC.tabBarController else { return }
        switch linkType {
        case .home:
            tabBarController.selectedIndex = 0
        case .myPage:
            tabBarController.selectedIndex = 3
        default:
            return
        }
    }
    
    @objc func handleRefresh() {
        customRefreshControl.beginRefreshing()
        viewModel.reloadData()
    }
}

extension NotificationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseIdentifier, for: indexPath) as! NotificationTableViewCell
        cell.delegate = self
        cell.swipeableDelegate = self
        let notification = viewModel.notificationList[indexPath.section]
        cell.configure(data: notification)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.notificationList[indexPath.section].link {
        case .home:
            moveToTabBar(linkType: .home)
        case .myPage:
            moveToTabBar(linkType: .myPage)
            /*
        case .stampBoard(let stampBoardID):
            //TODO: - 진영님이 추가하실곳.
            print("이동")
            return
             */
        case .coupon(let couponID):
            let viewModel = CouponDetailViewModel(repository: CouponDataRepository(), couponID: couponID)
            let couponDetailViewController = CouponDetailViewController(viewModel: viewModel)
            couponDetailViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(couponDetailViewController, animated: false)
        default:
            return
        }
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension NotificationViewController: NotificationTableViewCellDelegate {
    func didTapAcceptButton(_ cell: NotificationTableViewCell) {
        if let section = tableView.indexPath(for: cell)?.section {
            Task {
                if let memberID = viewModel.notificationList[section].sender?.id {
                    await viewModel.linkApproveDidTap(for: memberID)
                }
            }
        }
    }
    
    func didTapRejectButton(_ cell: NotificationTableViewCell) {
        if let section = tableView.indexPath(for: cell)?.section {
            Task {
                if let memberID = viewModel.notificationList[section].sender?.id {
                    await viewModel.linkRejectDidTap(for: memberID)
                }
            }
        }
    }
}

extension NotificationViewController: SwipeableTableViewCellDelegate {
    func didTapDeleteButton(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        Task {
            await viewModel.removeNotification(with: indexPath.section)
        }
    }
}


extension NotificationViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if true == viewModel.isApiFinishedLoadingSubject.value {
            customRefreshControl.resetRefreshControl()
        }
        viewModel.resetBottomRefreshSubjects()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        viewModel.didEndDraggingSubject.send(true)
        scrollViewDidReachEnd(scrollView)
    }
}
