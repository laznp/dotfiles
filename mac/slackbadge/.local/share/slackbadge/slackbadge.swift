// Mirrors Slack's unread state into the macOS menu bar.
//
// The menu bar has no notification area, so Slack's only native signal is the
// Dock badge -- invisible while the Dock auto-hides. lsappinfo reports that
// same badge without any permission prompt, which is why this reads it there
// rather than walking the Dock's accessibility tree like other tools do.
//
// Badge values: empty means nothing unread, "N" counts mentions and DMs, and
// a bullet means unread messages with no mention.

import AppKit

private let idleColour = NSColor(srgbRed: 0.67, green: 0.70, blue: 0.75, alpha: 1)   // #abb2bf
private let unreadColour = NSColor(srgbRed: 0.38, green: 0.69, blue: 0.94, alpha: 1) // #61afef
private let mentionColour = NSColor(srgbRed: 0.88, green: 0.12, blue: 0.35, alpha: 1) // #e01e5a

private let glyph = "\u{F04B1}" // nf-md-slack
private let refreshInterval: TimeInterval = 5

final class SlackBadge: NSObject, NSApplicationDelegate {
    private let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private var timer: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Lets macOS remember where the item was dragged to. Position is the
        // user's to set -- Command-drag moves it -- and without this the item
        // reappears wherever macOS pleases on every restart.
        item.autosaveName = "SlackBadge"
        item.button?.target = self
        item.button?.action = #selector(openSlack)
        render()
        timer = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true) { [weak self] _ in
            self?.render()
        }
    }

    @objc private func openSlack() {
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.tinyspeck.slackmacgap")
        else { return }
        NSWorkspace.shared.openApplication(at: url, configuration: NSWorkspace.OpenConfiguration())
    }

    /// The Dock badge label, or nil when Slack is not running or has nothing unread.
    private func badge() -> String? {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/lsappinfo")
        task.arguments = ["info", "-only", "StatusLabel", "Slack"]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = FileHandle.nullDevice
        do { try task.run() } catch { return nil }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()
        guard let out = String(data: data, encoding: .utf8) else { return nil }

        // Shaped like: "StatusLabel"={ "label"="3" }
        guard let range = out.range(of: "\"label\"=\"") else { return nil }
        let rest = out[range.upperBound...]
        guard let end = rest.firstIndex(of: "\"") else { return nil }
        let label = String(rest[..<end]).trimmingCharacters(in: .whitespaces)
        return label.isEmpty ? nil : label
    }

    private func render() {
        let label = badge()
        let isMention = label.map { $0.allSatisfy(\.isNumber) } ?? false

        let text: String
        let colour: NSColor
        switch (label, isMention) {
        case (nil, _):
            text = glyph
            colour = idleColour
        case (let value?, true):
            text = "\(glyph) \(value)"
            colour = mentionColour
        default:
            text = glyph
            colour = unreadColour
        }

        // The app picks its own font, so unlike rift's menu bar indicator the
        // Nerd Font glyph actually resolves here.
        let font = NSFont(name: "JetBrainsMono Nerd Font", size: 14)
            ?? NSFont.menuBarFont(ofSize: 14)

        item.button?.attributedTitle = NSAttributedString(
            string: text,
            attributes: [.font: font, .foregroundColor: colour]
        )
    }
}

let app = NSApplication.shared
let delegate = SlackBadge()
app.delegate = delegate
app.setActivationPolicy(.accessory)
app.run()
