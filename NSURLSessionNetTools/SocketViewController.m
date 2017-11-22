//
//  SocketViewController.m
//  NSURLSessionNetTools
//  客户端
//  Created by Thinkive on 2017/11/22.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "SocketViewController.h"
#import "GCDAsyncSocket.h"
#import "SocketServerViewController.h"

@interface SocketViewController ()<GCDAsyncSocketDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *portTF;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (nonatomic, strong) GCDAsyncSocket *socket;

@end

@implementation SocketViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark - ACTIONS
/**
 和服务器进行链接
 @discussion 与服务器通过三次握手建立连接
 @param sender 连接按钮
 */
- (IBAction)connect:(UIButton *)sender
{
    // 1. 创建一个socket对象
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    // 2. 与服务器的socket链接起来
    NSError *error = nil;
    BOOL result = [self.socket connectToHost:self.addressTF.text onPort:self.portTF.text.integerValue error:&error];
    // 3. 判断链接是否成功
    if (result) {
        [self addText:@"客户端链接服务器成功"];
    } else {
        [self addText:[NSString stringWithFormat:@"客户端链接服务器失败:%@", error]];
    }
}
/**
 接收数据
 @param sender 接收按钮
 */
- (IBAction)receiveMassage:(UIButton *)sender
{
    [self.socket readDataWithTimeout:-1 tag:0];
}
/**
 发送消息
 @param sender 发送按钮
 */
- (IBAction)sendMassage:(UIButton *)sender
{
    [self.socket writeData:[self.message.text dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
}
/**
 内容区显示消息
 @param text 内容
 */
- (void)addText:(NSString *)text
{
    self.content.text = [self.content.text stringByAppendingFormat:@"%@\n", text];
}
#pragma mark - GCDAsyncSocketDelegate
/**
 连接成功
 @discussion 客户端链接服务器端成功, 客户端获取地址和端口号
 @param sock socket
 @param host IP
 @param port 端口号
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"%s",__func__);
    [self addText:[NSString stringWithFormat:@"链接服务器%@", host]];
    MSSocket *socket = [MSSocket defaultSocket];
    socket.mySocket = self.socket;
}
/**
 断开连接
 @param sock socket
 @param err 错误信息
 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    if (err) {
        NSLog(@"连接失败");
    }else{
        NSLog(@"正常断开");
    }
}
/**
 读取数据
 @discussion 客户端已经获取到内容
 @param sock socket
 @param data 数据
 @param tag tag
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self addText:content];
}
/**
 数据发送成功
 @param sock socket
 @param tag tag
 */
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%s",__func__);
    //发送完数据手动读取，-1不设置超时
    [sock readDataWithTimeout:-1 tag:tag];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
