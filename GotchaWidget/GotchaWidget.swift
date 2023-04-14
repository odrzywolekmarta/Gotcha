//
//  GotchaWidget.swift
//  GotchaWidget
//
//  Created by Majka on 25/03/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(named: "Image") ?? UIImage())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), image: UIImage(named: "Image") ?? UIImage())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            guard let image = try? await PokemonImageService.fetchRandomPokemon() else {
                return
            }
            var entries: [SimpleEntry] = []
            
            let currentDate = Date()
                    for hourOffset in 0..<20 {
                        guard let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate) else {
                            continue
                        }
                        let entry = SimpleEntry(date: entryDate, image: image)
                        entries.append(entry)
                    }

                    let timeline = Timeline(entries: entries, policy: .atEnd)
                    completion(timeline)
        }
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
}

struct GotchaWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            BackgroundView()
            PokemonView(image: entry.image)
                .widgetURL(URL(string: WidgetConstants.detailsDeeplink))
        } // zstack
    }
}

struct GotchaWidget: Widget {
    let kind: String = "GotchaWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GotchaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct GotchaWidget_Previews: PreviewProvider {
    static var previews: some View {
        GotchaWidgetEntryView(entry: SimpleEntry(date: Date(), image: UIImage(named: "Image") ?? UIImage()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
