import ProjectDescription

let project = Project(
    name: "Alert",
    packages: [
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "Alert",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.Alert",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .package(product: "SnapKit"),
                .project(target: "PolzzakUIKit", path: "../PolzzakUIKit"),
                .project(target: "SharedResources", path: "../SharedResources"),
                .project(target: "Extension", path: "../Extension")
            ]
        ),
        Target(
            name: "AlertTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.AlertTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Alert"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "AlertDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.AlertDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "Alert")
            ]
        ),
        Target(
            name: "AlertDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.AlertDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "AlertDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
