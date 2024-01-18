import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorMediaPlugin)
public class CapacitorMediaPlugin: CAPPlugin {
    private let implementation = CapacitorMedia()
    
    @objc func getLatestVideoThumbnailFromAlbum(_ call: CAPPluginCall) {
        guard let albumName = call.getString("albumName") else {
            call.reject("Album name should be provided")
            return
        }
        guard let size: JSObject = call.getObject("size") else {
            call.reject("Size should be provided")
            return
        }
        implementation.getLatestVideoThumbnailFromAlbum(albumName: albumName, width: (size["width"] as? Int)!, height: (size["height"] as? Int)!) { base64String in
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
