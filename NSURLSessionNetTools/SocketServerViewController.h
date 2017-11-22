//
//  SocketServerViewController.h
//  NSURLSessionNetTools
//
//  Created by Thinkive on 2017/11/22.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"

@interface SocketServerViewController : UIViewController

@end


@interface MSSocket : NSObject
@property (nonatomic, strong) GCDAsyncSocket *mySocket;
// 创建一个单例
+ (MSSocket *)defaultSocket;
@end
