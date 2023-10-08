import ProjectDescription

let project = Project(
    name: "PullToRefresh",
    packages: [
            .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "PullToRefresh",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.PullToRefresh",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .package(product: "SnapKit"),
                .project(target: "SharedResources", path: "../SharedResources")
            ]
        ),
        Target(
            name: "PullToRefreshTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.PullToRefreshTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "PullToRefresh"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "PullToRefreshDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.PullToRefreshDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "PullToRefresh")
            ]
        ),
        Target(
            name: "PullToRefreshDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.PullToRefreshDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "PullToRefreshDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
