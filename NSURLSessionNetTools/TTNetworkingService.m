//
//  TTNetworkingService.m
//  NSURLSessionNetTools
//
//  Created by Thinkive on 2017/12/16.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "TTNetworkingService.h"
#import "TTNetworkingManager.h"

@implementation TTNetworkingService



/**
 同步发送图片
 
 @param images imagesArray
 */
- (void)syncSendImageMsgs:(NSArray *)images{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_queue_create("TTImageSendQueue", DISPATCH_QUEUE_CONCURRENT);
    
    for (UIImage *image in images) {
        
        dispatch_async(queue, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            [TTNetworkingManager uploadImageWithOperations:nil withImageArray:@[image] withtargetWidth:500 withUrlString:self.uploadUrl withSuccessBlock:^(NSDictionary *object) {
               
                dispatch_semaphore_signal(semaphore);
                
            } withFailurBlock:^(NSError *error) {
               
                dispatch_semaphore_signal(semaphore);
                
            } withUpLoadProgress:^(float progress) {
                
            }];
        });
    }
}



/**
 同步发送图片并获取完成通知
 
 @param images images
 */
- (void)syncSendImageMsgsAndGetCompleteNoti:(NSArray<UIImage *> *)images{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        for (UIImage *image in images) {
            dispatch_group_async(group, queue, ^{
                NSLog(@"*********");
                [TTNetworkingManager uploadImageWithOperations:nil withImageArray:@[image] withtargetWidth:500 withUrlString:self.uploadUrl withSuccessBlock:^(NSDictionary *object) {
                   
                    dispatch_semaphore_signal(semaphore);
                    
                } withFailurBlock:^(NSError *error) {
                   
                    dispatch_semaphore_signal(semaphore);
                    
                } withUpLoadProgress:^(float progress) {
                    
                }];
                
            });
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            
        });
    });
    
}




/**
 异步上传多张图片得到完成通知
 
 @param images images
 */
- (void)asyncSendImageAndGetCompleteNoti:(NSArray *)images{
    dispatch_queue_t queue = dispatch_queue_create("CEBCImageSendAsyQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        for (UIImage *image in images) {
            
            dispatch_group_enter(group);
            
            [TTNetworkingManager uploadImageWithOperations:nil withImageArray:@[image] withtargetWidth:500 withUrlString:self.uploadUrl withSuccessBlock:^(NSDictionary *object) {
                
                dispatch_group_leave(group);
                
            } withFailurBlock:^(NSError *error) {
                
                dispatch_group_leave(group);
                
            } withUpLoadProgress:^(float progress) {
                
            }];
        }
    });
    
    dispatch_group_notify(group, queue, ^{
        
    });
}



@end
