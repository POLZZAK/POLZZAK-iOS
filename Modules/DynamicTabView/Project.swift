import ProjectDescription

let project = Project(
    name: "DynamicTabView",
    packages: [
            .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "DynamicTabView",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.DynamicTabView",
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
            name: "DynamicTabViewTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.DynamicTabViewTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "DynamicTabView"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "DynamicTabViewDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.DynamicTabViewDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "DynamicTabView")
            ]
        ),
        Target(
            name: "DynamicTabViewDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.DynamicTabViewDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "DynamicTabViewDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
