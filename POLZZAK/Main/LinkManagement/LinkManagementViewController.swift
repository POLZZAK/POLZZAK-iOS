//
//  LinkManagementViewController.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/06/09.
//

import UIKit
import SnapKit

final class LinkManagementViewController: UIViewController {
    
    //MARK: - let, var
    var userType: UserType
    let screenWidth = UIApplication.shared.width
    private var workItem: DispatchWorkItem?
    
    //TODO: - 임시코드, 새로운 API통신을 했다는 가정
    private var beforeState: LinkTabStyle = .receivedTab
    private var linkManagementTabState: LinkTabStyle = .linkListTab {
        didSet {
            //TODO: - 새로운 API통신을 했다는 가정
            fullScreenLoadingView.startLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                if beforeState != linkManagementTabState {
                    testData = dummyFmailyData.families
                }
                
                testData = dummyFmailyData.families
                
                switch linkManagementTabState {
                case .linkListTab:
                    tableEmptyView.setStyle(LinkEmptyStyle.linkListTab)
                case .receivedTab:
                    tableEmptyView.setStyle(LinkEmptyStyle.receivedTab)
                case .sentTab:
                    tableEmptyView.setStyle(LinkEmptyStyle.sentTab)
                }
                
                tableView.backgroundView = tableEmptyView
                tableView.reloadData()
                
                self.fullScreenLoadingView.stopLoading()
            }
        }
    }
    
    //TODO: - 임시데이터
    private var testData: [FamilyMember] = dummyFmailyData.families {
        didSet {
            if testData.isEmpty {
                tableEmptyView.showBackgroundView()
            } else {
                tableEmptyView.hideBackgroundView()
            }
            tableView.reloadData()
        }
    }
    
    private var searchState: SearchState = .beforeSearch(isSearchBarActive: false) {
        didSet {
            switch searchState {
            case .beforeSearch(isSearchBarActive: let isSearchBarActive):
                if false == isSearchBarActive {
                    searchEmptyView.isHidden = true
                    tableView.isHidden = false
                    searchLoadingView.isHidden = true
                    searchResultView.isHidden = true
                } else {
                    searchEmptyView.isHidden = false
                    tableView.isHidden = true
                    searchLoadingView.isHidden = true
                    searchResultView.isHidden = true
                }
            case .searching(let text):
                searchEmptyView.isHidden = true
                tableView.isHidden = true
                searchLoadingView.isHidden = false
                searchResultView.isHidden = true
                searching(text: text ?? "")
            case .afterSearch:
                searchEmptyView.isHidden = true
                tableView.isHidden = true
                searchLoadingView.isHidden = true
                searchResultView.isHidden = false
            }
        }
    }
    
    private var searchResultState: SearchResultState = .notSearch {
        didSet {
            switch searchResultState {
            case .linked(let familyMember):
                let style = SearchResultState.linked(familyMember)
                searchResultView.setStyle(style: style)
            case .unlinked(let familyMember):
                let style = SearchResultState.unlinked(familyMember)
                searchResultView.setStyle(style: style)
            case .nonExist(let nickname):
                let style = SearchResultState.nonExist(nickname)
                searchResultView.setStyle(style: style)
            case .notSearch:
                return
            }
            searchCancel(keyboard: false)
        }
    }
    
    //MARK: - UI
    private var tableEmptyView: EmptyView = EmptyView(style: LinkEmptyStyle.linkListTab)
    private lazy var searchEmptyView: EmptyView = {
        let emptyView = EmptyView(style: LinkSearchEmptyStyle.searchDefault(userType))
        emptyView.isHidden = true
        return emptyView
    }()
    private var searchResultView: SearchResultView = SearchResultView()
    private var fullScreenLoadingView = FullScreenLoadingView(style: .linkmanagement)
    
    private let searchLoadingView: SearchLoadingView = {
        let searchLoadingView = SearchLoadingView()
        searchLoadingView.isHidden = true
        searchLoadingView.isUserInteractionEnabled = true
        return searchLoadingView
    }()
    
    private lazy var searchBar: SearchBar = {
        let screenWidth = UIApplication.shared.width
        let searchBar = SearchBar(frame: CGRect(x: 16, y: 0, width: screenWidth - 32, height: 44), style: .linkManagement(userType))
        return searchBar
    }()
    
    private let tabContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let tabViews: TabViews = {
        let tabViews = TabViews(tabStyle: .linkListTab)
        return tabViews
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(LinkListTabCell.self, forCellReuseIdentifier: LinkListTabCell.reuseIdentifier)
        tableView.register(ReceivedTabCell.self, forCellReuseIdentifier: ReceivedTabCell.reuseIdentifier)
        tableView.register(SentTabCell.self, forCellReuseIdentifier: SentTabCell.reuseIdentifier)
        
        tableView.rowHeight = 54
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    init(userType: UserType) {
        self.userType = userType
        super.init(nibName: nil, bundle: nil)
        
        setNavigation()
        setUI()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: - API통신
        linkManagementTabState = .linkListTab
        setAction()
    }
}

extension LinkManagementViewController {
    private func setNavigation() {
        title = "연동 관리"
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                .font: UIFont.subtitle1
            ]
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        [searchBar, tabContentView, searchEmptyView, searchLoadingView, searchResultView, fullScreenLoadingView].forEach {
            view.addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        tabContentView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        [tabViews, tableView].forEach {
            tabContentView.addSubview($0)
        }
        
        tabViews.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(tabViews.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        searchEmptyView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchLoadingView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchResultView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        fullScreenLoadingView.snp.makeConstraints {
            $0.top.equalTo(tabViews.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func setDelegate() {
        tabViews.delegate = self
        searchBar.delegate = self
        searchResultView.delegate = self
    }
    
    private func setAction() {
        searchLoadingView.cancelButton.addTarget(self, action: #selector(searchCancel), for: .touchUpInside)
    }
    
    private func linkListTabTapped() {
        //TODO: - 새로운 API통신을 했다는 가정
        beforeState = linkManagementTabState
        
        linkManagementTabState = .linkListTab
    }
    
    private func receivedTabTapped() {
        //TODO: - 새로운 API통신을 했다는 가정
        beforeState = linkManagementTabState
        
        linkManagementTabState = .receivedTab
    }
    
    private func sentTabTapped() {
        //TODO: - 새로운 API통신을 했다는 가정
        beforeState = linkManagementTabState
        
        linkManagementTabState = .sentTab
    }
}

extension LinkManagementViewController: TabViewsDelegate {
    func tabViews(_ tabViews: TabViews, didSelectTabAtIndex index: Int) {
        switch index {
        case 0:
            linkListTabTapped()
        case 1:
            receivedTabTapped()
        case 2:
            sentTabTapped()
        default:
            break
        }
    }
}

extension LinkManagementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let family = testData[indexPath.row]
        switch linkManagementTabState {
        case .linkListTab:
            let cell = tableView.dequeueReusableCell(withIdentifier: LinkListTabCell.reuseIdentifier) as! LinkListTabCell
            cell.delegate = self
            cell.configure(with: family)
            return cell
        case .receivedTab:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedTabCell.reuseIdentifier) as! ReceivedTabCell
            cell.delegate = self
            cell.configure(family: family)
            return cell
        case .sentTab:
            let cell = tableView.dequeueReusableCell(withIdentifier: SentTabCell.reuseIdentifier) as! SentTabCell
            cell.delegate = self
            cell.configure(family: family)
            return cell
        }
    }
    
    private func showAlert(alertStyle: AlertStyleProtocol, memberId: Int) {
        let action = { [weak self] (completion: @escaping () -> Void) in
            if let alertStyle = alertStyle as? LinkAlertStyle,
               case .linkRequest(_) = alertStyle {
                self?.tempLinkRequest(memberId: memberId) {
                    completion()
                    self?.searchResultView.requestCompletion()
                }
            } else {
                self?.tempRemove(memberId: memberId) {
                    completion()
                }
            }
            
            return
        }
        
        let alertVC = CustomAlertViewController(alertStyle: alertStyle, action: action)
        alertVC.modalPresentationStyle = .overCurrentContext
        present(alertVC, animated: false)
    }
    
    //    TODO: - API통신 취소 기능 추가
    @objc func searchCancel(keyboard: Bool = true) {
        workItem?.cancel()
        if true == keyboard {
            searchState = .beforeSearch(isSearchBarActive: true)
        }
        searchBar.isCancelState.toggle()
        searchBar.activate(bool: true, keyboard: keyboard)
    }
    
    // TODO: - 임시 삭제 API 함수
    func tempRemove(memberId: Int = -1, completion: @escaping () -> Void) {
        if memberId == -1 {
            testData = dummyFmailyData.families
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                if let index = self?.testData.firstIndex(where: { $0.memberId == memberId }) {
                    self?.testData.remove(at: index)
                }
                completion()
            }
        }
    }
    
    //TODO: - 임시 연동요청 API 함수
    func tempLinkRequest(memberId: Int = -1, completion: @escaping () -> Void) {
        if memberId == -1 {
            testData = dummyFmailyData.families
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion()
            }
        }
    }
    
    //TODO: - 임시 요청취소 API 함수
    @objc private func requestCancel(memberId: Int = -1, completion: @escaping () -> Void) {
        if memberId == -1 {
            testData = dummyFmailyData.families
        } else {
            fullScreenLoadingView.startLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.fullScreenLoadingView.stopLoading()
                completion()
            }
        }
    }
    
    //TODO: - 임시데이터를 포함한 검색로직
    private func searching(text: String) {
        workItem?.cancel()
        
        workItem = DispatchWorkItem { [weak self] in
            self?.searchState = .afterSearch
            if text == "연동" {
                let tempFamilyMember = tempDummyData.first!.familyMember
                self?.searchResultState = .unlinked(tempFamilyMember)
            } else if text == "미연동" {
                let tempFamilyMember = tempDummyData.first!.familyMember
                self?.searchResultState = .linked(tempFamilyMember)
            } else {
                self?.searchResultState = .nonExist(text)
            }
        }
        
        if let workItem = workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: workItem)
        }
    }
}

// MARK: - LinkListTabCellDelegate
extension LinkManagementViewController: LinkListTabCellDelegate {
    func didTapClose(on cell: LinkListTabCell) {
        if let family = cell.family {
            showAlert(alertStyle: LinkAlertStyle.unlink(family.nickName), memberId: family.memberId)
        }
    }
}

//MARK: - ReceivedTabCellDelegate
extension LinkManagementViewController: ReceivedTabCellDelegate {
    func didTapAccept(on cell: ReceivedTabCell) {
        if let family = cell.family {
            showAlert(alertStyle: LinkAlertStyle.receivedAccept(family.nickName), memberId: family.memberId)
        }
    }
    
    func didTapReject(on cell: ReceivedTabCell) {
        if let family = cell.family {
            showAlert(alertStyle: LinkAlertStyle.receivedReject(family.nickName), memberId: family.memberId)
        }
    }
}

//MARK: - SentTabCellDelegate
extension LinkManagementViewController: SentTabCellDelegate {
    func didTapCancel(on cell: SentTabCell) {
        if let family = cell.family {
            showAlert(alertStyle: LinkAlertStyle.requestCancel(family.nickName), memberId: family.memberId)
        }
    }
}

//MARK: - SearchBarDelegate
extension LinkManagementViewController: SearchBarDelegate {
    func searchBarDidBeginEditing(_ searchBar: SearchBar) {
        if searchBar.searchBarSubView.searchBarTextField.text == "" {
            searchState = .beforeSearch(isSearchBarActive: true)
        }
    }
    
    func searchBarDidEndEditing(_ searchBar: SearchBar) {
        if searchState == .searching() {
            searchEmptyView.isHidden = false
            tableView.isHidden = true
            searchLoadingView.isHidden = true
        } else {
            searchState = .beforeSearch(isSearchBarActive: false)
        }
    }
    
    func search(_ searchBar: SearchBar, searchText: String) {
        searchLoadingView.configure(nickName: searchText)
        searchState = .searching(nickName: searchText)
    }
}

//MARK: - SearchResultViewDelegate
extension LinkManagementViewController: SearchResultViewDelegate {
    func linkRequest(alertStyle: LinkAlertStyle, memberId: Int) {
        self.showAlert(alertStyle: alertStyle, memberId: memberId)
    }
    
    func linkRequestCancel(memberId: Int) {
        self.requestCancel(memberId: memberId) { [weak self] in
            guard let self = self else { return }
            let style = LabelStyle(text: "요청이 취소됐어요", font: .body2, backgroundColor: .error500)
            let toast = Toast(style: style, image: .informationButton)
            toast.show(controller: self)
            self.searchResultView.requestCancel()
        }
    }
}
