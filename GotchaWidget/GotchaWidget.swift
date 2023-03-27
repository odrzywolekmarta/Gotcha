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
        SimpleEntry(date: Date(), url: getImageUrl())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), url: getImageUrl())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = SimpleEntry(date: startOfDate, url: getImageUrl())
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let url: URL?
}

struct GotchaWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
           BackgroundView()
            VStack {
                Text("WHO'S THAT")
                    .font(.system(size: 12))
                    .fontWeight(.black)
                    .scaledToFit()
                
                // image
                PokeImage(url: entry.url)
                            
                Text("POKEMON?")
                    .font(.system(size: 12))
                    .fontWeight(.black)
            } // vstack
            .padding(8)
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
    }
}

struct GotchaWidget_Previews: PreviewProvider {
    static var previews: some View {
        GotchaWidgetEntryView(entry: SimpleEntry(date: Date(), url: getImageUrl()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
