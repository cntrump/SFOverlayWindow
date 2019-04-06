# SFOverlayWindow

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

add `-fmodules -fcxx-modules` to `OTHER_CPLUSPLUSFLAGS` for your project settings
