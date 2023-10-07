import ProjectDescription

let project = Project(
    name: "Extension",
    packages: [],
    targets: [
        Target(
            name: "Extension",
            platform: .iOS,
            product: .framework,
            bundleId: "polzzak.module.Extension",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: []
        )
    ]
)
