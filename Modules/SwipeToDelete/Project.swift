import ProjectDescription

let project = Project(
    name: "SwipeToDelete",
    packages: [
            .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "SwipeToDelete",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.SwipeToDelete",
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
            name: "SwipeToDeleteDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.SwipeToDeleteDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "SwipeToDelete")
            ]
        ),
        Target(
            name: "SwipeToDeleteDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.SwipeToDeleteDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "SwipeToDeleteDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
