# SFOverlayWindow [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Present any UIViewController within an UIWindow

## SFAlertWindow

a wrapper of UIAlertController with `alert` style

```swift
let alert = SFAlertWindow(title: "title", message: "message")
alert.addAction(title: "default 1", style: .default)
alert.addAction(title: "default 2", style: .default)
alert.addAction(title: "default 3", style: .default)
alert.addAction(title: "destructive", style: .destructive)
alert.addAction(title: "cancel", style: .cancel)
alert.show()
```

## SFActionSheetWindow

a wrapper of UIAlertController with `actionSheet` style

```swift
let actionSheet = SFActionSheetWindow(title: "title", message: "message")
actionSheet.addAction(title: "default 1", style: .default)
actionSheet.addAction(title: "default 2", style: .default)
actionSheet.addAction(title: "default 3", style: .default)
actionSheet.addAction(title: "destructive", style: .destructive)
actionSheet.addAction(title: "cancel", style: .cancel)
actionSheet.show()
```

## SFSafariWindow

a wrapper of SFSafariViewController

```swift
let url = URL(string: "https://github.com")
let safariWindow = SFSafariWindow.window()

if #available(iOS 10.0, *) {
    safariWindow.preferredBarTintColor = .black
    safariWindow.preferredControlTintColor = .white
}

if #available(iOS 11.0, *) {
    safariWindow.dismissButtonStyle = .close
}

safariWindow.present(url!, animated: true)
```

## Present Custom UIViewController

```swift
SFOverlayWindow.window().present(CustomViewController(), animated: true)
```
### Using in your project

using `carthage`

```
github "cntrump/SFOverlayWindow" "master"
```

#### Swift

```swift
import SFOverlayWindow
```

#### Objc

```objc
@import SFOverlayWindow;
```

enable `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` in your project settings

if your project using Objc++

add `-fmodules -fcxx-modules` to `OTHER_CPLUSPLUSFLAGS` in your project settings
