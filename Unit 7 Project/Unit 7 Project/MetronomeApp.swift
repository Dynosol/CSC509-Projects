//
//  MetronomeApp.swift
//  Unit 7 Project
//
//  Created by Sol Kim on 2/15/22.
//

import SwiftUI
import CoreHaptics
import AVFoundation

// Dictionary of system sounds
let sounds = [
    "tick": UInt32(1103),
    "tock": UInt32(1104),
    "dmf": UInt32(1200),
    "slh": UInt32(1256),
    "tink": UInt32(1057)
]

// Height of the play/pause metronome button for scaling
let buttonHeight = sHeight*(0.20)

struct MetronomeApp: View {
    @ObservedObject var userModel: UserModel
    
    // Haptic engine for vibration
    @State var engine: CHHapticEngine?
    // Learned start stop timer from: https://stackoverflow.com/questions/63548432/swiftui-how-to-make-a-start-stop-timer
    @State var isTimerRunning = false
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // dummy value
    // Triggers the ticking for the centerbody
    @State var tick = false
    // Changes if the metronome is going or not; modifies the look of the play button
    @State var playOrStopIcon: String = "play"
    // Used for the blue flash up display balls to indicate time in measure
    @State var runningCount: Int = 0
    
    // Stops metronome
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    // Starts metronome
    func startTimer() {
        self.timer = Timer.publish(every: userModel.user.subdivision/Double(userModel.user.bpm), on: .main, in: .common).autoconnect()
    }
    
    // Learned haptic functions from: https://www.hackingwithswift.com/books/ios-swiftui/making-vibrations-with-uinotificationfeedbackgenerator-and-core-haptics
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    // Vibrate devices
    func vibrate() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 0.1)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    var body: some View {
        VStack (spacing: 0){
            // Navigation bar
            TopBar(userModel: userModel)
            // Tap body
            CenterBody(userModel: userModel, tick: $tick, runningCount: $runningCount)
            
            // Play Button
            ZStack {
                isTimerRunning ? Color.red : Color.green
                
                Image(systemName: playOrStopIcon)
                    .font(.system(size: buttonHeight*(0.4)))
                    .foregroundColor(.white)
                    .accessibilityLabel(playOrStopIcon)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityRemoveTraits(.isImage)
            }
            // Toggle tick, play sound, and vibrate when timer is ticked
            .onReceive(timer) { _ in
                if self.isTimerRunning {
                    tick.toggle()
                    AudioServicesPlaySystemSound(sounds[userModel.user.sound]!)
                    vibrate()
                    runningCount += 1
                }
            }
            // Prepare haptics for vibration
            .onAppear{
                prepareHaptics()
                // no need for UI updates at startup
                self.stopTimer()
            }
            .onTapGesture {
                // Vibrate on press
                vibrate()
                
                if isTimerRunning {
                    self.stopTimer()
                    playOrStopIcon = "play"
                    runningCount = 0
                // If start metronome is clicked, start the timer, tick, play sound
                } else {
                    self.startTimer()
                    tick.toggle()
                    AudioServicesPlaySystemSound(sounds[userModel.user.sound]!)
                    playOrStopIcon = "stop"
                    runningCount += 1
                }
                isTimerRunning.toggle()
            }
        }
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
    }
}
