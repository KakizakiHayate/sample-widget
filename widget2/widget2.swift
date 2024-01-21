//
//  widget2.swift
//  widget2
//
//  Created by 柿崎逸 on 2024/01/21.
//

import WidgetKit
import SwiftUI
import AVFoundation

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (
            SimpleEntry
        ) -> ()
    ) {
        let entry = SimpleEntry(
            date: Date(),
            emoji: "😀"
        )
        completion(
            entry
        )
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (
            Timeline<Entry>
        ) -> ()
    ) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(
                byAdding: .hour,
                value: hourOffset,
                to: currentDate
            )!
            let entry = SimpleEntry(
                date: entryDate,
                emoji: "😀"
            )
            entries.append(
                entry
            )
        }

        let timeline = Timeline(
            entries: entries,
            policy: .atEnd
        )
        completion(
            timeline
        )
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct widget2EntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Image(systemName: "speaker.wave.1")
                .font(.title)
            Text("音量\(loadVolume())")
        }
//        .onAppear {
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.setActive(true)
//                let volume = audioSession.outputVolume
//                print("Output Volume: \(volume)")
//            } catch {
//                print("Failed to set audio session active: \(error)")
//            }
//        }
    }

    func loadVolume() -> Float {
        let sharedDefaults = UserDefaults(suiteName: "group.com.hayate.app.SampleWidget")
        return sharedDefaults?.float(forKey: "volume") ?? 1
    }
}

struct widget2: Widget {
    let kind: String = "widget2"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                widget2EntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                widget2EntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies(supportedFamilies)
    }

    private var supportedFamilies: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, *) {
            return [
                .systemSmall,
                .systemMedium,
                .systemLarge,
                .systemExtraLarge,
                .accessoryInline,
                .accessoryCircular,
                .accessoryRectangular
            ]
        } else {
            return [
                .systemSmall,
                .systemMedium,
                .systemLarge
            ]
        }
    }
}

#Preview(as: .systemSmall) {
    widget2()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
