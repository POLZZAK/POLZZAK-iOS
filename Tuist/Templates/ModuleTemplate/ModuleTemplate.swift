import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Custom template",
    attributes: [
        nameAttribute
    ],
    items: [
        .directory(
            path: "Modules/\(nameAttribute)/Sources",
            sourcePath: ".gitkeep"
        ),
        .directory(
            path: "Modules/\(nameAttribute)/Resources",
            sourcePath: ".gitkeep"
        ),
        .file(
            path: "Modules/\(nameAttribute)/Project.swift",
            templatePath: "Project.stencil"
        ),
        .file(
            path: "Modules/\(nameAttribute)/Config/Info.plist",
            templatePath: "Info.plist.stencil"
        ),
        .file(
            path: "Modules/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
            templatePath: "ModuleTests.stencil"
        ),
        .file(
            path: "Modules/\(nameAttribute)/DemoApp/DemoAppSources/AppDelegate.swift",
            templatePath: "AppDelegate.stencil"
        ),
        .file(
            path: "Modules/\(nameAttribute)/DemoApp/DemoAppSources/SceneDelegate.swift",
            templatePath: "SceneDelegate.stencil"
        ),
        .file(
            path: "Modules/\(nameAttribute)/DemoApp/DemoAppSources/ViewController.swift",
            templatePath: "ViewController.stencil"
        ),
        .file(
            path: "Modules/\(nameAttribute)/DemoApp/DemoAppResources/LaunchScreen.storyboard",
            templatePath: "LaunchScreen.stencil"
        ),
        .file(
            path: "Modules/\(nameAttribute)/DemoApp/DemoAppUITests/\(nameAttribute)DemoAppUITests.swift",
            templatePath: "DemoAppUITests.stencil"
        )
    ]
)
