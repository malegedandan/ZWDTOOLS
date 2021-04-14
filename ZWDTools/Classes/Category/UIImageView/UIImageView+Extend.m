//
//  UIImageView+Extend.m
//  wbxUser
//
//  Created by WBX on 2020/7/27.
//  Copyright © 2020 哒哒哒. All rights reserved.
//

#import "UIImageView+Extend.h"
#import <AVKit/AVKit.h>
//#import "NSString+Password.h"

@implementation UIImageView (Extend)
//获取视频第一帧图片优化（异步加载数据）
-(void)wbx_setVideoPreViewImageURL:(NSURL *)path placeHolderImage:(UIImage *)placeHolder
{
    NSString *name = [[path absoluteString] MD5];//视频链接转MD5作为图片的名字
    //NSString *name = [path absoluteString];
    NSString *PATH = [NSString stringWithFormat:@"%@/Documents/videoFolder/%@.png",NSHomeDirectory(),name];
    UIImage *imagePath = [[UIImage alloc] initWithContentsOfFile:PATH];
    if (imagePath) {
        //本地有缓存图片，加载本地图片并return
        self.image = imagePath;
        return;
    }else{
        //本地没有缓存图片，先加载占位图
        self.image = placeHolder;
    }
    
    dispatch_group_t group = dispatch_group_create();
    __block UIImage *videoImage;
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
        AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        assetGen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 2);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        videoImage = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        
        //创建文件夹
        NSString *folder = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/videoFolder"];
        [[NSFileManager defaultManager] createDirectoryAtPath:folder withIntermediateDirectories:NO attributes:nil error:nil];
        [UIImagePNGRepresentation(videoImage) writeToFile:PATH atomically:YES];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //主线程更新UI
        self.image = videoImage;
    });
}

@end
