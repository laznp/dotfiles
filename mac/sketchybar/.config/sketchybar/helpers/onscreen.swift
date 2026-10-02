// Prints the CGWindowNumber of every window macOS still considers on-screen.
//
// OmniWM parks windows of inactive workspaces far off the display, yet macOS
// keeps reporting those as on-screen. A minimised window is the one case that
// flips kCGWindowIsOnscreen to false, so this is how the bar tells a workspace
// holding only minimised windows apart from one that is genuinely in use.
//
// OmniWM's windowId is the same identifier as kCGWindowNumber, so callers can
// join the two lists directly. Needs no accessibility or screen-recording
// permission: window names are never read.

import CoreGraphics
import Foundation

let options: CGWindowListOption = [.optionAll, .excludeDesktopElements]
guard let windows = CGWindowListCopyWindowInfo(options, kCGNullWindowID) as? [[String: Any]] else {
    exit(1)
}

for window in windows {
    guard window[kCGWindowIsOnscreen as String] as? Bool == true,
          let number = window[kCGWindowNumber as String] as? Int else { continue }
    print(number)
}
