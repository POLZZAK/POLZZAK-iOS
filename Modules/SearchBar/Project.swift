import ProjectDescription

let project = Project(
    name: "SearchBar",
    packages: [
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "SearchBar",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.SearchBar",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "SharedResources", path: "../SharedResources")
            ]
        ),
        Target(
            name: "SearchBarTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.SearchBarTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "SearchBar"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "SearchBarDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.SearchBarDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "SearchBar")
            ]
        ),
        Target(
            name: "SearchBarDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.SearchBarDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "SearchBarDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
