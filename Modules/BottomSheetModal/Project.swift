import ProjectDescription

let project = Project(
    name: "BottomSheetModal",
    packages: [
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0")),
            .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        Target(
            name: "BottomSheetModal",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.BottomSheetModal",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .package(product: "SnapKit"),
                .project(target: "Extension", path: "../Extension"),
                .project(target: "SharedResources", path: "../SharedResources")
            ]
        ),
        Target(
            name: "BottomSheetModalTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.BottomSheetModalTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "BottomSheetModal"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "BottomSheetModalDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.BottomSheetModalDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "BottomSheetModal")
            ]
        ),
        Target(
            name: "BottomSheetModalDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.BottomSheetModalDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "BottomSheetModalDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
