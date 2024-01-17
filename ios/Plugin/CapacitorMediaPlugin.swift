import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorMediaPlugin)
public class CapacitorMediaPlugin: CAPPlugin {
    private let implementation = CapacitorMedia()
    
    @objc func getLatestVideoThumbnail(_ call: CAPPluginCall) {
        guard let albumName = call.getString("albumName") else {
            call.reject("Album name should be provided")
            return
        }
        implementation.getLatestVideoThumbnail(albumName: albumName) { base64String in
            if let base64String = base64String {
                call.resolve([
                    "value": base64String
                ])
            } else {
                call.reject("No thumbnail image was found or access was denied.")
                return
            }
        }
    }
}
