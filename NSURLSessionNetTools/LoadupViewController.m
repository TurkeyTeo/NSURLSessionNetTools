//
//  LoadupViewController.m
//  NSURLSessionNetTools
//
//  Created by Thinkive on 2017/11/15.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "LoadupViewController.h"
#import "DownLoadManager.h"

/**
 要实现断点续传的功能，通常都需要客户端记录下当前的下载进度，并在需要续传的时候通知服务端本次需要下载的内容片段。
 
 在HTTP1.1协议（RFC2616）中定义了断点续传相关的HTTP头的Range和Content-Range字段，一个最简单的断点续传实现大概如下：
 
 客户端下载一个1024K的文件，已经下载了其中512K
 网络中断，客户端请求续传，因此需要在HTTP头中申明本次需要续传的片段：
 Range:bytes=512000-
 这个头通知服务端从文件的512K位置开始传输文件
 服务端收到断点续传请求，从文件的512K位置开始传输，并且在HTTP头中增加：
 Content-Range:bytes 512000-/1024000
 并且此时服务端返回的HTTP状态码应该是206，而不是200。
 
 **/
 


@interface LoadupViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipLab;

@end

@implementation LoadupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (IBAction)start:(id)sender {
    // 启动任务
    NSString * downLoadUrl =  @"http://audio.xmcdn.com/group11/M01/93/AF/wKgDa1dzzJLBL0gCAPUzeJqK84Y539.m4a";
    
    __weak typeof(self) weakSelf = self;
    [[DownLoadManager sharedInstance]downLoadWithURL:downLoadUrl progress:^(float progress) {
        NSLog(@"###%f",progress);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.tipLab.text = [NSString stringWithFormat:@"%f",progress];
        });
        
    } success:^(NSString *fileStorePath) {
        NSLog(@"###%@",fileStorePath);
        
    } faile:^(NSError *error) {
        NSLog(@"###%@",error.userInfo[NSLocalizedDescriptionKey]);
    }];
    
}

- (IBAction)stop:(id)sender {
    [[DownLoadManager sharedInstance]stopTask];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
