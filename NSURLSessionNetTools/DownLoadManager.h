//
//  DownLoadManager.h
//  NSURLSessionNetTools
//
//  Created by Thinkive on 2017/11/15.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock) (NSString *fileStorePath);
typedef void (^faileBlock) (NSError *error);
typedef void (^progressBlock) (float progress);

@interface DownLoadManager : NSObject<NSURLSessionDataDelegate>

@property (copy) successBlock  successBlock;
@property (copy) faileBlock      failedBlock;
@property (copy) progressBlock    progressBlock;

-(void)downLoadWithURL:(NSString *)URL
              progress:(progressBlock)progressBlock
               success:(successBlock)successBlock
                 faile:(faileBlock)faileBlock;

+ (instancetype)sharedInstance;

-(void)stopTask;

@end
