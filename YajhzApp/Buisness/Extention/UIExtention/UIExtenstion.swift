//
//  UrlExtenstion.swift
//  PantherAppIOS
//
//  Created by Ahmed Maher on 12/8/19.
//  Copyright © 2019 MahmoudOrganization. All rights reserved.
//
import Foundation
import UIKit
import AVKit

extension URL {
    
    func getDurationInSeconds() -> (Int, Int) {
        let videoUrl  = AVURLAsset(url: self)
        let durationInSeconds = videoUrl.duration.seconds
        let durationInHours = Int(durationInSeconds)/60
        let  reminderSeconds = Int(durationInSeconds) % 60
        return(durationInHours, reminderSeconds)
    }
    
    func  generateThumbImage(url: NSURL) -> UIImage {
        let asset = AVAsset(url: url as URL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        var time = asset.duration
        time.value = CMTimeValue(0)
        var imageRef: CGImage?
        do {
            imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
        } catch {
        }
        var thumbnail: UIImage?
        if let imageRef = imageRef {
            thumbnail = UIImage(cgImage: imageRef)
        }
        return thumbnail ?? UIImage(named: "logo")!
        
    }
    
    func resolutionSizeVideo(url: NSURL) -> CGSize? {
        var videoTrack: AVAssetTrack?
        let asset = AVAsset(url: url as URL) as? AVURLAsset
        let videoTracks = asset?.tracks(withMediaType: .video)
        
        var formatDescription: CMFormatDescription?
        let formatDescriptions = videoTrack?.formatDescriptions
        if (formatDescriptions?.count ?? 0) > 0 {
            formatDescription = (formatDescriptions?[0] as! CMFormatDescription?)!
        }
        
        if (videoTracks?.count ?? 0) > 0 {
            videoTrack = videoTracks?[0]
        }
        
        var trackDimensions = CGSize()
        trackDimensions.width = CGFloat(Int(0.0))
        trackDimensions.height = CGFloat(Int(0.0))
        trackDimensions = videoTrack?.naturalSize ?? CGSize.zero
        let width = Int(trackDimensions.width)
        let height = Int(trackDimensions.height)
        let frameRate = videoTrack?.nominalFrameRate
        let bps = videoTrack?.estimatedDataRate
        return CGSize(width: width, height: height)
    }
    
    func toData() -> Data {
        do {
            return try  Data(contentsOf: self, options: .mappedIfSafe)
        } catch {
            print(error)
            
        }
        return Data()
    }
    
}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
extension String{
    var isNumeric: Bool
    {
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return (range == nil)
    }
    
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
}


