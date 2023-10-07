import ProjectDescription

let project = Project(
    name: "SharedResources",
    packages: [],
    targets: [
        Target(
            name: "SharedResources",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.SharedResources",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        )
    ]
)
