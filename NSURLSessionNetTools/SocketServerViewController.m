//
//  SocketServerViewController.m
//  NSURLSessionNetTools
//  服务端
//  Created by Thinkive on 2017/11/22.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "SocketServerViewController.h"


@implementation MSSocket
+ (MSSocket *)defaultSocket
{
    static MSSocket *socket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socket = [[self alloc] init];
    });
    return socket;
}
@end



@interface SocketServerViewController ()<GCDAsyncSocketDelegate>

@property (weak, nonatomic) IBOutlet UITextField *portTF;   // 端口号
@property (weak, nonatomic) IBOutlet UITextField *content;
@property (weak, nonatomic) IBOutlet UITextView *message;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket; // 为客户端生成的socket
@property (nonatomic, strong) GCDAsyncSocket *serverSocket; // 服务器socket

@end

@implementation SocketServerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark - ACTIONS
/**
 监听
 @param sender 监听按钮
 */
- (IBAction)listen:(id)sender
{
    // 1. 创建服务器socket
    self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    // 2. 开放哪些端口
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:self.portTF.text.integerValue error:&error];
    // 3. 判断端口号是否开放成功
    if (result) {
        [self addText:@"端口开放成功"];
    } else {
        [self addText:@"端口开放失败"];
    }
}

// textView填写内容
- (void)addText:(NSString *)text
{
    self.message.text = [self.message.text stringByAppendingFormat:@"%@\n", text];
}
/**
 发送消息
 @param sender 发送按钮
 */
- (IBAction)sendMessage:(id)sender
{
    NSData *data = [self.content.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
    MSSocket *socket = [MSSocket defaultSocket];
    [socket.mySocket readDataWithTimeout:-1 tag:0];
}
/**
 接收数据
 @param sender 接收
 */
- (IBAction)receiveMessage:(id)sender
{
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
#pragma mark - GCDAsyncSocketDelegate
/**
 当客户端链接服务器端的socket, 为客户端单生成一个socket
 @param sock socket
 @param newSocket 为客户端单生成一个新socket
 */
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    [self addText:@"链接成功"];
    // IP: newSocket.connectedHost
    // 端口号: newSocket.connectedPort
    [self addText:[NSString stringWithFormat:@"链接地址:%@", newSocket.connectedHost]];
    [self addText:[NSString stringWithFormat:@"端口号:%hu", newSocket.connectedPort]];
    // short: %hd
    // unsigned short: %hu
    // 存储新的端口号
    self.clientSocket = newSocket;
}
/**
 读取数据
 @param sock socket
 @param data 接收到的数据
 @param tag tag
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self addText:message];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
