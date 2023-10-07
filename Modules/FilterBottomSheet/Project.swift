import ProjectDescription

let project = Project(
    name: "FilterBottomSheet",
    packages: [
            .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "FilterBottomSheet",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.FilterBottomSheet",
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
            name: "FilterBottomSheetTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.FilterBottomSheetTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "FilterBottomSheet"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "FilterBottomSheetDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.FilterBottomSheetDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "FilterBottomSheet")
            ]
        ),
        Target(
            name: "FilterBottomSheetDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.FilterBottomSheetDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "FilterBottomSheetDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
