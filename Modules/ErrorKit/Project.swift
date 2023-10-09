import ProjectDescription

let project = Project(
    name: "ErrorKit",
    packages: [
            .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0"))
    ],
    targets: [
        Target(
            name: "ErrorKit",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.ErrorKit",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: []
        ),
        Target(
            name: "ErrorKitTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "polzzak.module.ErrorKitTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "ErrorKit"),
                .package(product: "Nimble")
            ]
        ),
        Target(
            name: "ErrorKitDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "polzzak.demo.ErrorKitDemoApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["DemoApp/DemoAppSources/**"],
            resources: ["DemoApp/DemoAppResources/**"],
            dependencies: [
                .target(name: "ErrorKit")
            ]
        ),
        Target(
            name: "ErrorKitDemoAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "polzzak.demo.ErrorKitDemoApp.UITests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["DemoApp/DemoAppUITests/**"],
            dependencies: [
                .target(name: "ErrorKitDemoApp"),
                .package(product: "Nimble")
            ]
        )
    ]
)
