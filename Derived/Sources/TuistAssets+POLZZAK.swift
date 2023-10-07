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
public enum POLZZAKAsset {
  public static let calendarLeft = POLZZAKImages(name: "calendar_left")
  public static let calendarRight = POLZZAKImages(name: "calendar_right")
  public static let issueStampCalender = POLZZAKImages(name: "issue_stamp_calender")
  public static let agreementCheckCircleFilled = POLZZAKImages(name: "agreement_check_circle_filled")
  public static let appleLogo = POLZZAKImages(name: "apple_logo")
  public static let cancelCircle = POLZZAKImages(name: "cancel.circle")
  public static let chevronRightSmall = POLZZAKImages(name: "chevron_right_small")
  public static let greeting = POLZZAKImages(name: "greeting")
  public static let kakaoLogo = POLZZAKImages(name: "kakao_logo")
  public static let loginChildImage = POLZZAKImages(name: "login_child_image")
  public static let loginParentImage = POLZZAKImages(name: "login_parent_image")
  public static let nicknameCheck = POLZZAKImages(name: "nickname_check")
  public static let selectProfileImage1 = POLZZAKImages(name: "select_profile_image1")
  public static let selectProfileImage2 = POLZZAKImages(name: "select_profile_image2")
  public static let missonDeleteImage = POLZZAKImages(name: "misson_delete_image")
  public static let missonListImage = POLZZAKImages(name: "misson_list_image")
  public static let newStampBoardArrowBack = POLZZAKImages(name: "new_stamp_board_arrow_back")
  public static let newStampBoardNeedsStamp = POLZZAKImages(name: "new_stamp_board_needs_stamp")
  public static let newStampBoardRefreshImage = POLZZAKImages(name: "new_stamp_board_refresh_image")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct POLZZAKImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = POLZZAKResources.bundle
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

public extension POLZZAKImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the POLZZAKImages.image property")
  convenience init?(asset: POLZZAKImages) {
    #if os(iOS) || os(tvOS)
    let bundle = POLZZAKResources.bundle
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
