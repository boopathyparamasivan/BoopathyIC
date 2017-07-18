//
//  ImageCompression.swift
//  Pods
//
//  Created by Boopathy P on 23/05/17.
//
//

import Foundation
import UIKit

public class ImageCompression
{
    public func compressImageByScaling( image : CGImage, maxWidth : CGFloat, maxHeight : CGFloat ) -> CGImage
    {
        var actImgWidth : CGFloat = CGFloat( image.width )
        var actImgHeight : CGFloat = CGFloat( image.height )
        
        var imageRatio : CGFloat = actImgWidth / actImgHeight
        let maxRatio : CGFloat = maxWidth / maxHeight
        if ( ( actImgHeight > maxHeight ) || ( actImgWidth > maxWidth ) )
        {
            if ( imageRatio < maxRatio )
            { // changing image width accordingly maxHeight
                imageRatio = maxHeight / actImgHeight ;
                actImgWidth = imageRatio * actImgWidth ;
                actImgHeight = maxHeight ;
            }
            else if ( imageRatio > maxRatio )
            { // changing image height accordingly maxWidth
                imageRatio = maxWidth / actImgWidth ;
                actImgHeight = imageRatio * actImgHeight ;
                actImgWidth = maxWidth ;
            }
            else
            {
                actImgHeight = maxHeight ;
                actImgWidth = maxWidth ;
            }
        }
        
        let colorSpace : CGColorSpace = image.colorSpace!
        let bitmapInfo = image.bitmapInfo
        let context = CGContext(data: nil, width: Int(actImgWidth), height: Int(actImgHeight), bitsPerComponent: image.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        if( context == nil )
        {
            return image ;
        }
        
        context?.draw(image, in: CGRect(x: 0.0,y: 0.0,width: actImgWidth,height: actImgHeight))
        
        let compressedImage : CGImage = context!.makeImage()!  // extract resulting image from context
        return compressedImage
    }
}


