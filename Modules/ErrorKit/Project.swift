import ProjectDescription

let project = Project(
    name: "ErrorKit",
    packages: [],
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
        )
    ]
)
