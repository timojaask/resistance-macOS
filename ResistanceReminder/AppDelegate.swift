import Cocoa

let flashInterval = TimeInterval(60 * 5)
let regularText = "Resistance"
let attentionText = "RSSTNC"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var timer: Timer?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setTitle(regularText)
        timer = Timer.scheduledTimer(withTimeInterval: flashInterval, repeats: true, block: { _ in
            self.drawAttention()
        })
    }
    
    func drawAttention() {
        DispatchQueue.main.async {
            self.setTitle(attentionText, foregroundColor: NSColor.white, backgroundColor: NSColor.red)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
            self.setTitle(regularText, foregroundColor: NSColor.white, backgroundColor: NSColor.red)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            self.setTitle(attentionText, foregroundColor: NSColor.white, backgroundColor: NSColor.red)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
            self.setTitle(regularText)
        }
    }
    
    func setTitle(_ title: String, foregroundColor: NSColor, backgroundColor: NSColor) {
        let attributes = [
            NSAttributedStringKey.foregroundColor: foregroundColor,
            NSAttributedStringKey.backgroundColor: backgroundColor
        ]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        statusItem.length = CGFloat(title.count * 8)
        statusItem.attributedTitle = attributedText
    }
    
    func setTitle(_ title: String) {
        statusItem.length = CGFloat(title.count * 8)
        statusItem.title = title
    }
}

