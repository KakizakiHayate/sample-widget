//
//  widget2LiveActivity.swift
//  widget2
//
//  Created by 柿崎逸 on 2024/01/21.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct widget2Attributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct widget2LiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: widget2Attributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension widget2Attributes {
    fileprivate static var preview: widget2Attributes {
        widget2Attributes(name: "World")
    }
}

extension widget2Attributes.ContentState {
    fileprivate static var smiley: widget2Attributes.ContentState {
        widget2Attributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: widget2Attributes.ContentState {
         widget2Attributes.ContentState(emoji: "🤩")
     }
}

//#Preview("Notification", as: .content, using: widget2Attributes.preview) {
//   widget2LiveActivity()
//} contentStates: {
//    widget2Attributes.ContentState.smiley
//    widget2Attributes.ContentState.starEyes
//}
