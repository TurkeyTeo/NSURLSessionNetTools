//
//  TTNetworkingService.h
//  NSURLSessionNetTools
//
//  Created by Thinkive on 2017/12/16.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TTNetworkingService : NSObject

@property (nonatomic, copy) NSString *uploadUrl;


/**
 同步发送图片
 
 @param images imagesArray
 */
- (void)syncSendImageMsgs:(NSArray *)images;


/**
 同步发送图片并获取完成通知
 
 @param images images
 */
- (void)syncSendImageMsgsAndGetCompleteNoti:(NSArray<UIImage *> *)images;


/**
 异步上传多张图片得到完成通知
 
 @param images images
 */
- (void)asyncSendImageAndGetCompleteNoti:(NSArray *)images;



@end
