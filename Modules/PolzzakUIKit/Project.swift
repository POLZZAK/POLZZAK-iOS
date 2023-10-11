import ProjectDescription

let project = Project(
    name: "PolzzakUIKit",
    packages: [
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "PolzzakUIKit",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.PolzzakUIKit",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .package(product: "SnapKit"),
                .project(target: "Extension", path: "../Extension"),
                .project(target: "SharedResources", path: "../SharedResources")
            ]
        ),
        Target(
            name: "PolzzakUIKitTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.PolzzakUIKitTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "PolzzakUIKit"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "PolzzakUIKitDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.PolzzakUIKitDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "PolzzakUIKit")
            ]
        ),
        Target(
            name: "PolzzakUIKitDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.PolzzakUIKitDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "PolzzakUIKitDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
