import ProjectDescription
import ProjectDescriptionHelpers

#if DEBUG
let entitlementsPath: Path = .relativeToRoot("Config/POLZZAK_Debug.entitlements")
#else
let entitlementsPath: Path = .relativeToRoot("Config/POLZZAK_Release.entitlements")
#endif

let project = Project(
    name: "POLZZAK",
    packages: [
        .package(url: "https://github.com/kakao/kakao-ios-sdk", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/z3rosmith/PanModal", .branch("use-in-POLZZAK")),
        .package(url: "https://github.com/CombineCommunity/CombineCocoa", .upToNextMajor(from: "0.2.1")),
        .package(url: "https://github.com/WenchaoD/FSCalendar", .upToNextMajor(from: "2.8.3")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "12.0.0")),
        .package(url: "https://github.com/Brightify/Cuckoo", .upToNextMajor(from: "1.9.1"))
    ],
    targets: [
        Target(
            name: "POLZZAK",
            platform: .iOS,
            product: .app,
            bundleId: "com.z3rosmith.POLZZAK",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Config/Info.plist",
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: entitlementsPath,
            dependencies: [
                .package(product: "KakaoSDKUser"),
                .package(product: "KakaoSDKAuth"),
                .package(product: "SnapKit"),
                .package(product: "PanModal"),
                .package(product: "CombineCocoa"),
                .package(product: "FSCalendar"),
                .project(target: "SharedResources", path: "Modules/SharedResources")
//                .project(target: "Toast", path: "Modules/Toast"),
//                .project(target: "SearchBar", path: "Modules/SearchBar"),
//                .project(target: "Alert", path: "Modules/Alert"),
//                .project(target: "PolzzakUIKit", path: "Modules/PolzzakUIKit"),
//                .project(target: "BottomSheet", path: "Modules/BottomSheet"),
//                .project(target: "TabViews", path: "Modules/TabViews"),
//                .project(target: "SkeletonView", path: "Modules/SkeletonView"),
//                .project(target: "LoadingModule", path: "Modules/LoadingModule"),
//                .project(target: "FilterView", path: "Modules/FilterView"),
//                .project(target: "ErrorModule", path: "Modules/ErrorModule"),
//                .project(target: "PullToRefresh", path: "Modules/PullToRefresh")
            ]
        ),
        Target(
            name: "POLZZAKTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.z3rosmith.POLZZAKTests",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
            infoPlist: "Tests/POLZZAKTests/TestInfo.plist",
            sources: ["Tests/**"],
            resources: ["Tests/POLZZAKTests/Mocks/SampleDatas/**"],
            scripts: [.generateMocks],
            dependencies: [
                .target(name: "POLZZAK"),
                .package(product: "Nimble"),
                .package(product: "Cuckoo")
            ]
        )
    ]
)
