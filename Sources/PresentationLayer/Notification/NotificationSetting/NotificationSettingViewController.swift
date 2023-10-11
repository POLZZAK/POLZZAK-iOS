//
//  NotificationSettingViewController.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/07/13.
//

import UIKit
import SnapKit
import Combine
import Toast

final class NotificationSettingViewController: UIViewController {
    private let viewModel: NotificationViewModel
    private var cancellables = Set<AnyCancellable>()
    private var selectSwitch: Int?
    
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(text: "모든알림", textColor: .gray800, font: .subtitle16Sbd)
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.setLabel(textColor: .gray500, font: .caption12Md)
        return label
    }()
    
    let allSettingSwitch: UISwitch = {
        let customSwitch = UISwitch()
        customSwitch.onTintColor = .blue500
        return customSwitch
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NotificationSettingTableViewCell.self, forCellReuseIdentifier: NotificationSettingTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    init(viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigation()
        setupTbleView()
        setupAction()
        bindViewModel()
        addBecameActiveObserver()
    }
}

extension NotificationSettingViewController {
    private func setupUI() {
        view.backgroundColor = .gray100
        
        [headerView, bottomLine, tableView].forEach {
            view.addSubview($0)
        }
        
        [titleLabel, allSettingSwitch].forEach {
            headerView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.height.equalTo(allSettingSwitch.snp.height)
        }
        
        allSettingSwitch.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        bottomLine.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(bottomLine.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigation() {
        title = "알림 설정"
    }
    
    private func setupTbleView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .gray100
        
        Task {
            allSettingSwitch.isOn = await checkNotificationAuthorizationStatus()
            viewModel.fetchNotificationSettingList()
        }
    }
    
    private func setupAction() {
        allSettingSwitch.addTarget(self, action: #selector(openAppSettings), for: .valueChanged)
    }
    
    private func bindViewModel() {
        viewModel.$notificationSettingList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.tableView.reloadData()
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
    
    private func addBecameActiveObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(appBecameActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func notificationSwitchTapped(_ mySwitch: UISwitch) {
        if let appSettingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettingsUrl, options: [:], completionHandler: nil)
        }
    }
    
    @objc func appBecameActive() {
        Task {
            print("allSettingSwitch_4", allSettingSwitch.isOn)
            let isAuthorized = await checkNotificationAuthorizationStatus()
            print("allSettingSwitch_5", allSettingSwitch.isOn)
            if allSettingSwitch.isOn != isAuthorized {
                print("allSettingSwitch_6", allSettingSwitch.isOn)
                allSettingSwitch.isOn = isAuthorized
                print("allSettingSwitch_7", allSettingSwitch.isOn)
                handleSelectedSetting(bool: isAuthorized)
            }
            print("allSettingSwitch_8", allSettingSwitch.isOn)
        }
    }
    
    @objc func openAppSettings(bool: Bool = false) {
        if false == bool {
            allSettingSwitch.isOn = !allSettingSwitch.isOn
        }
        guard let appSettingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(appSettingsUrl) else {
            return
        }
        
        UIApplication.shared.open(appSettingsUrl, options: [:], completionHandler: nil)
    }
    
    func checkNotificationAuthorizationStatus() async -> Bool {
        return await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    continuation.resume(returning: true)
                case .denied:
                    continuation.resume(returning: false)
                default:
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    private func handleAllSetting(bool: Bool) {
        allSettingSwitch.isOn = bool
        viewModel.updateNotificationSetting(bool: bool)
        selectSwitch = nil
    }
    
    private func handleSelectedSetting(bool: Bool) {
        if let index = selectSwitch {
            viewModel.updateNotificationSetting(index: index)
        } else {
            self.handleAllSetting(bool: bool)
        }
    }
}

extension NotificationSettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notificationSettingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationSettingTableViewCell.reuseIdentifier, for: indexPath) as! NotificationSettingTableViewCell
        let titleText = viewModel.indexToNotificationSettingTitle(indexPath.row)
        let detailText = viewModel.indexToNotificationSettingDetail(indexPath.row)
        let isEnable = viewModel.indexToNotificationSettingisEnabled(indexPath.row)
        cell.delegate = self
        cell.configure(titleText: titleText, detailText: detailText, isSwitchOn: isEnable, tag: indexPath.row)
        
        if indexPath.row == 6 {
            cell.hideBottomLine()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52 + 32
    }
}

extension NotificationSettingViewController: NotificationSettingTableViewCellDelegate {
    func didTapSwitchButton(_ cell: NotificationSettingTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if true == allSettingSwitch.isOn {
                viewModel.updateNotificationSetting(index: indexPath.row)
            } else {
                selectSwitch = indexPath.row
                openAppSettings(bool: true)
            }
        }
    }
}
