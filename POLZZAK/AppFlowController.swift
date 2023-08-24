//
//  AppFlowController.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/05/11.
//

import UIKit

final class AppFlowController {
    static let shared = AppFlowController()
    
    private var window: UIWindow?
    private var rootViewController: UIViewController? {
        didSet {
            animateChangingRootViewController(rootViewController)
        }
    }
    
    private init() {}
    
    func show(in window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
        showLoading()
    }
    
    func showLoading() {
        rootViewController = InitialLoadingViewController()
    }
    
    func showHome() {
        //
        let navController = UINavigationController(rootViewController: RegisterTermsViewController())
        navController.navigationBar.tintColor = .gray700
        // 아래 4줄은 navController의 BackButton의 title을 안 보이게 하기 위해서 사용함
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        barButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        barButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        //
        rootViewController = navController // getHomeViewController()
    }
    
    func showLogin() {
        rootViewController = getLoginViewController()
    }
    
    private func animateChangingRootViewController(_ rootViewController: UIViewController?) {
        guard let window else { return }
        UIView.transition(with: window, duration: 0.1, options: .transitionCrossDissolve, animations: {
            window.rootViewController = rootViewController
        })
    }
    
    private func getHomeViewController() -> TabBarController {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = nil
        
        //TODO: - 로그인 및 회원상태에 따라 분기처리할 예정
        if false == tempDummyData.isEmpty {
            let mainViewController = MainViewController(userInformations: tempDummyData)
            mainViewController.tabBarItem = UITabBarItem(title: "메인", image: .mainTabBarIcon, tag: 0)
            let mainNavigationController = UINavigationController(rootViewController: mainViewController)
            mainNavigationController.navigationBar.standardAppearance = navBarAppearance
            mainNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            let couponViewController = UIViewController()
            couponViewController.tabBarItem = UITabBarItem(title: "쿠폰", image: .couponTabBarIcon, tag: 1)
            let couponNavigationController = UINavigationController(rootViewController: couponViewController)
            couponNavigationController.navigationBar.standardAppearance = navBarAppearance
            couponNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            let notificationViewController = NotificationViewController()
            notificationViewController.tabBarItem = UITabBarItem(title: "알림", image: .notificationTabBarIcon, tag: 2)
            let notificationNavigationController = UINavigationController(rootViewController: notificationViewController)
            notificationNavigationController.navigationBar.standardAppearance = navBarAppearance
            notificationNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            let myPageViewController = UIViewController()
            myPageViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: .myPageTabBarIcon, tag: 3)
            let myPageNavigationController = UINavigationController(rootViewController: myPageViewController)
            myPageNavigationController.navigationBar.standardAppearance = navBarAppearance
            myPageNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            let tabBarController = TabBarController()
            tabBarController.viewControllers = [
                mainNavigationController,
                couponNavigationController,
                notificationNavigationController,
                myPageNavigationController
            ]
            
            tabBarController.modalPresentationStyle = .fullScreen
            
            return tabBarController
        } else {
            return TabBarController()
        }
    }
    
    private func getLoginViewController() -> UIViewController {
        let navController = UINavigationController(rootViewController: LoginViewController())
        navController.navigationBar.tintColor = .gray700
        // 아래 4줄은 navController의 BackButton의 title을 안 보이게 하기 위해서 사용함
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        barButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        barButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        return navController
    }
}