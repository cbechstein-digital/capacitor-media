import Foundation
import UIKit
import Photos
import AVFoundation

@objc public class CapacitorMedia: NSObject {
    @objc public func getLatestVideoThumbnail(albumName: String, completion: @escaping (String?) -> Void) {
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
            DispatchQueue.main.async {
                switch status {
                    case .authorized:
                        self.fetchAlbum(withName: albumName) { album in
                            if let album = album {
                                self.fetchLatestVideoThumbnail(from: album, completion: completion)
                            } else {
                                completion(nil)
                            }
                        }
                    case .denied, .restricted, .notDetermined:
                        completion(nil)
                    default:
                        completion(nil)
                }
            }
        }
    }
    
    private func fetchAlbum(withName albumName: String, completion: @escaping (PHAssetCollection?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollections(with: fetchOptions)
        if let album = collections.firstObject {
            completion(album)
        } else {
            completion(nil)
        }
    }
    
    private func fetchLatestVideoThumbnail(from album: PHAssetCollection, completion: @escaping (String?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)

        let fetchResult = PHAsset.fetchAssets(in: album, options: fetchOptions)
        if let latestVideo = fetchResult.firstObject {
            let imageManager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = false
            requestOptions.deliveryMode = .highQualityFormat
            
            let targetSize = CGSize(width: 200, height: 200)
            
            imageManager.requestImage(for: latestVideo,
                                      targetSize: targetSize,
                                      contentMode: .aspectFit,
                                      options: requestOptions) { image, _ in
                DispatchQueue.main.async {
                    if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
                        let base64String = imageData.base64EncodedString()
                        let dataUri = "data:image/jpeg;base64," + base64String
                        completion(dataUri)
                    } else {
                        completion(nil)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}
