import ProjectDescription

let project = Project(
    name: "Loading",
    packages: [
            .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "Loading",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.Loading",
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
            name: "LoadingTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.LoadingTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Loading"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "LoadingDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.LoadingDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "Loading")
            ]
        ),
        Target(
            name: "LoadingDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.LoadingDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "LoadingDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
