import Foundation
import UIKit
import Photos
import AVFoundation

@objc public class CapacitorMedia: NSObject {
    @objc public func getLatestVideoThumbnailFromAlbum(albumName: String, width: Int, height: Int, completion: @escaping (String?) -> Void) {
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
            DispatchQueue.main.async {
                switch status {
                    case .authorized:
                        self.fetchAlbum(withName: albumName, withWidth: width, withHeight: height) { album in
                            if let album = album {
                                self.fetchLatestVideoThumbnailFromAlbum(from: album, withWidth: width, withHeight: height, completion: completion)
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
    
    public func openPhotosApp(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "photos-redirect://") else {
            completion(.failure(PhotoOpenerError.invalidURL))
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    completion(.success(()))
                } else {
                    completion(.failure(PhotoOpenerError.cannotOpenURL))
                }
            }
        } else {
            completion(.failure(PhotoOpenerError.unableToOpenURL))
        }
    }
    
    private func fetchAlbum(withName albumName: String, withWidth width: Int, withHeight height: Int, completion: @escaping (PHAssetCollection?) -> Void) {
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
    
    private func fetchLatestVideoThumbnailFromAlbum(from album: PHAssetCollection, withWidth width: Int, withHeight height: Int, completion: @escaping (String?) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)

        let fetchResult = PHAsset.fetchAssets(in: album, options: fetchOptions)
        if let latestVideo = fetchResult.firstObject {
            let imageManager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = false
            requestOptions.deliveryMode = .highQualityFormat
            
            let targetSize = CGSize(width: width, height: height)
            
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

enum PhotoOpenerError: Error {
    case invalidURL
    case cannotOpenURL
    case unableToOpenURL
}

