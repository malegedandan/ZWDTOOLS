//
//  UIImage+Extend.h
//  CDHN
//
//  Created by muxi on 14-10-14.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (Extend)





/**
 *  拉伸图片:自定义比例
 */
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;





/**
 *  拉伸图片
 */
+(UIImage *)resizeWithImageName:(NSString *)name;


/**
 *  获取启动图片
 */
+(UIImage *)launchImage;




/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param failBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)(void))completeBlock failBlock:(void(^)(void))failBlock;

/**
 获取网络视频第一帧图片
 */
+ (UIImage*)thumbnailImageForVideo:(NSString *)videoURL;


+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;
+ (UIImage *)getImageStream:(CVImageBufferRef)imageBuffer;
+ (UIImage *)getSubImage:(CGRect)rect inImage:(UIImage*)image;

-(UIImage *)originalImage;
@end
