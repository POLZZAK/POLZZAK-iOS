import ProjectDescription
import ProjectDescriptionHelpers

#if DEBUG
let entitlementsPath: Entitlements = .file(path: "Config/POLZZAK_Debug.entitlements")
#else
let entitlementsPath: Entitlements = .file(path: "Config/POLZZAK_Release.entitlements")
#endif

let project = Project(
    name: "POLZZAK",
    packages: [
        .package(url: "https://github.com/kakao/kakao-ios-sdk", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/z3rosmith/PanModal", .branch("use-in-POLZZAK")),
        .package(url: "https://github.com/CombineCommunity/CombineCocoa", .upToNextMajor(from: "0.2.1")),
        .package(url: "https://github.com/WenchaoD/FSCalendar", .upToNextMajor(from: "2.8.3")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", .exact("10.15.0")),
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
                .package(product: "FirebaseAnalytics"),
                .package(product: "FirebaseMessaging"),
                .project(target: "Alert", path: "Modules/Alert"),
                .project(target: "BottomSheetModal", path: "Modules/BottomSheetModal"),
                .project(target: "DynamicTabView", path: "Modules/DynamicTabView"),
                .project(target: "Extension", path: "Modules/Extension"),
                .project(target: "FilterBottomSheet", path: "Modules/FilterBottomSheet"),
                .project(target: "SharedResources", path: "Modules/SharedResources"),
                .project(target: "Loading", path: "Modules/Loading"),
                .project(target: "PolzzakUIKit", path: "Modules/PolzzakUIKit"),
                .project(target: "PullToRefresh", path: "Modules/PullToRefresh"),
                .project(target: "SearchBar", path: "Modules/SearchBar"),
                .project(target: "Toast", path: "Modules/Toast")
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
