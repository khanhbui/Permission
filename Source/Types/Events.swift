//
// Events.swift
//
// Copyright (c) 2015-2019 Damien (http://delba.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#if PERMISSION_EVENTS
import EventKit

extension Permission {
    var statusEvents: PermissionStatus {
        let status = EKEventStore.authorizationStatus(for: .event)

        switch status {
        case .authorized:          return .authorized
        case .restricted, .denied: return .denied
        case .notDetermined:       return .notDetermined
        @unknown default:          return .notDetermined
        }
    }

    func requestEvents(_ callback: @escaping Callback) {
        guard let _ = Foundation.Bundle.main.object(forInfoDictionaryKey: .eventsUsageDescription) else {
            print("WARNING: \(String.eventsUsageDescription) not found in Info.plist")
            return
        }

        EKEventStore().requestAccess(to: .event) { _, _ in
            callback(self.statusEvents)
        }
    }
}
#endif
