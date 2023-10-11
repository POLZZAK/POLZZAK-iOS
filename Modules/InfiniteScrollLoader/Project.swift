import ProjectDescription

let project = Project(
    name: "InfiniteScrollLoader",
    packages: [
            .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "InfiniteScrollLoader",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.InfiniteScrollLoader",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: []
        ),
        Target(
            name: "InfiniteScrollLoaderDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.InfiniteScrollLoaderDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "InfiniteScrollLoader"),
                .package(product: "SnapKit"),
                .project(target: "SharedResources", path: "../SharedResources")
            ]
        ),
        Target(
            name: "InfiniteScrollLoaderDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.InfiniteScrollLoaderDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "InfiniteScrollLoaderDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
