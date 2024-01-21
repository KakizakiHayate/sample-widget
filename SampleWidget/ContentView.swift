//
//  ContentView.swift
//  SampleWidget
//
//  Created by 柿崎逸 on 2024/01/21.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                let volume = audioSession.outputVolume
                print("Output Volume: \(volume)")
                let sharedDefault = UserDefaults(
                    suiteName: "group.com.hayate.app.SampleWidget"
                )
                guard let sharedDefault else {
                    print("userdefaultの取得に失敗")
                    return
                }
                sharedDefault.set(volume, forKey: "volume")
                print("\(sharedDefault.float(forKey: "volume"))")
            } catch {
                print("Failed to set audio session active: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
