// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum SharedResourcesAsset {
  public static let accentColor = SharedResourcesColors(name: "AccentColor")
  public static let blindTextColor = SharedResourcesColors(name: "blindTextColor")
  public static let gray100 = SharedResourcesColors(name: "gray100")
  public static let gray200 = SharedResourcesColors(name: "gray200")
  public static let gray300 = SharedResourcesColors(name: "gray300")
  public static let gray400 = SharedResourcesColors(name: "gray400")
  public static let gray500 = SharedResourcesColors(name: "gray500")
  public static let gray600 = SharedResourcesColors(name: "gray600")
  public static let gray700 = SharedResourcesColors(name: "gray700")
  public static let gray800 = SharedResourcesColors(name: "gray800")
  public static let blue100 = SharedResourcesColors(name: "blue100")
  public static let blue150 = SharedResourcesColors(name: "blue150")
  public static let blue200 = SharedResourcesColors(name: "blue200")
  public static let blue400 = SharedResourcesColors(name: "blue400")
  public static let blue500 = SharedResourcesColors(name: "blue500")
  public static let blue600 = SharedResourcesColors(name: "blue600")
  public static let blue700 = SharedResourcesColors(name: "blue700")
  public static let error100 = SharedResourcesColors(name: "error100")
  public static let error200 = SharedResourcesColors(name: "error200")
  public static let error500 = SharedResourcesColors(name: "error500")
  public static let searchButton = SharedResourcesImages(name: "SearchButton")
  public static let acceptButton = SharedResourcesImages(name: "acceptButton")
  public static let addStampBoardButton = SharedResourcesImages(name: "addStampBoardButton")
  public static let closeButton = SharedResourcesImages(name: "closeButton")
  public static let filterButton = SharedResourcesImages(name: "filterButton")
  public static let informationButton = SharedResourcesImages(name: "informationButton")
  public static let myConnectionsButton = SharedResourcesImages(name: "myConnectionsButton")
  public static let notificationSettingButton = SharedResourcesImages(name: "notificationSettingButton")
  public static let pictureButton = SharedResourcesImages(name: "pictureButton")
  public static let rejectButton = SharedResourcesImages(name: "rejectButton")
  public static let rightArrowButton = SharedResourcesImages(name: "rightArrowButton")
  public static let trashButton = SharedResourcesImages(name: "trashButton")
  public static let couponEmptyCharacter = SharedResourcesImages(name: "couponEmptyCharacter")
  public static let defaultProfileCharacter = SharedResourcesImages(name: "defaultProfileCharacter")
  public static let raisingOneHandCharacter = SharedResourcesImages(name: "raisingOneHandCharacter")
  public static let raisingTwoHandCharacter = SharedResourcesImages(name: "raisingTwoHandCharacter")
  public static let sittingCharacter = SharedResourcesImages(name: "sittingCharacter")
  public static let barcode = SharedResourcesImages(name: "barcode")
  public static let completedGradationView = SharedResourcesImages(name: "completedGradationView")
  public static let coupon = SharedResourcesImages(name: "coupon")
  public static let couponCompleted = SharedResourcesImages(name: "couponCompleted")
  public static let refreshDragImage = SharedResourcesImages(name: "refreshDragImage")
  public static let requestGradationView = SharedResourcesImages(name: "requestGradationView")
  public static let rewardCompleted = SharedResourcesImages(name: "rewardCompleted")
  public static let searchImage = SharedResourcesImages(name: "searchImage")
  public static let mail = SharedResourcesImages(name: "mail")
  public static let couponTabBarIcon = SharedResourcesImages(name: "couponTabBarIcon")
  public static let mainTabBarIcon = SharedResourcesImages(name: "mainTabBarIcon")
  public static let myPageTabBarIcon = SharedResourcesImages(name: "myPageTabBarIcon")
  public static let notificationTabBarIcon = SharedResourcesImages(name: "notificationTabBarIcon")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class SharedResourcesColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension SharedResourcesColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: SharedResourcesColors) {
    let bundle = SharedResourcesResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct SharedResourcesImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = SharedResourcesResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension SharedResourcesImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the SharedResourcesImages.image property")
  convenience init?(asset: SharedResourcesImages) {
    #if os(iOS) || os(tvOS)
    let bundle = SharedResourcesResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
