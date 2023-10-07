import ProjectDescription

let project = Project(
    name: "Toast",
    packages: [
            .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "Toast",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.Toast",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .package(product: "SnapKit"),
                .project(target: "SharedResources", path: "../SharedResources"),
                .project(target: "Extension", path: "../Extension")
            ]
        ),
        Target(
            name: "ToastTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.ToastTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "Toast"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "ToastDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.ToastDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "Toast")
            ]
        ),
        Target(
            name: "ToastDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.ToastDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "ToastDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
