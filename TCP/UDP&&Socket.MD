## 1. OSI模型

> OSI 模型(Open System Interconnection model)是一个由国际标准化组织􏰁提出的概念模型,试图􏰁供一个使各种不同的计算机和网络在世界范围内实现互联的标准框架。
> 它将计算机网络体系结构划分为七层,每层都可以􏰁供抽象良好的接口。了解 OSI 模型有助于理解实际上互联网络的工业标准——TCP/IP 协议。

![osi7.png](http://upload-images.jianshu.io/upload_images/3261360-1bdbef0da20abb23.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###1.1 OSI七层模型介绍：

1. **物理层** ：物理层负责最后将信息编码成电流脉冲或其它信号用于网上传输；
   `eg：RJ45等将数据转化成0和1；`

2. **数据链路层** ：数据链路层通过物理网络链路􏰁供数据传输。不同的数据链路层定义了不同的网络和协议特征,其中包括物理编址、网络拓扑结构、错误校验、数据帧序列以及流控;
   `可以简单的理解为：规定了0和1的分包形式，确定了网络数据包的形式；`

3. **网络层** ：网络层负责在源和终点之间建立连接;
   `可以理解为，此处需要确定计算机的位置，怎么确定？IPv4，IPv6！`

4. **传输层** ：是OSI中最**重要**的一层，它负责总体的数据传输和数据控制，向高层􏰁提供可靠的端到端的网络数据流服务。

   `可以理解为：每一个应用程序都会在网卡注册一个端口号，该层就是端口与端口的通信！常用的（TCP／IP）协议；`

5. **会话层** ：会话层建立、管理和终止表示层与实体之间的通信会话；
   `建立一个连接（自动的手机信息、自动的网络寻址）;`

6. **表示层** ：表示层􏰁供多种功能用于应用层数据编码和转化,以确保以一个系统应用层发送的信息 可以被另一个系统应用层识别;
   `可以理解为：解决不同系统之间的通信，eg：Linux下的QQ和Windows下的QQ可以通信；`

7. **应用层** ：OSI 的应用层协议包括文件的传输、访问及管理协议(FTAM) ,以及文件虚拟终端协议(VIP)和公用管理系统信息(CMIP)等;
   `规定数据的传输协议；`

   ​

### 1.2 TCP/IP 协议族常用协议

- 应用层：TFTP，HTTP，SNMP，FTP，SMTP，DNS，Telnet 等等
- 传输层：TCP，UDP
- 网络层：IP，ICMP，OSPF，EIGRP，IGMP
- 数据链路层：SLIP，CSLIP，PPP，MTU

1. IP(Internet Protocol,网际协议)是网间层的主要协议,任务是在源地址和和目的地址之间传输数据。IP 协议只是尽最大努力来传输数据包,并不保证所有的包都可以传输 到目的地,也不保证数据包的顺序和唯一。IP 定义了 TCP/IP 的地址,寻址方法,以及路由规则。现在广泛使用的 IP 协议有 IPv4 和 IPv6 两种。IP 地址由两部分组成,即网络号和主机号。故一个完整的 IPv4 地址往往表示 为 192.168.0.1/24 或192.168.0.1/255.255.255.0 这种形式。
2. TCP(TransmissionControlProtocol,传输控制协议)是一种面向连接的,可靠的, 基于字节流传输的通信协议。TCP 具有端口号的概念,用来标识同一个地址上的不同应用。
3. UDP(UserDatagramProtocol,用户数据报协议)是一个面向数据报的传输层协议。UDP 的传输是不可靠的,发送者不会知道目标地址的数据通路是否发生拥塞,也不知道数据是否到达,是否完整以及是否还是原来的顺序。
4. DHCP(DynamicHostConfigrationProtocol,动态主机配置协议)是用于局域网自动分配 IP 地址和主机配置的协议。可以使局域网的部署更加简单。
5. DNS(DomainNameSystem,域名系统)是互联网的一项服务,可以简单的将用“.” 分隔的一般会有意义的域名转换成不易记忆的 IP 地址。一般使用 UDP 协议传输, 也可以使用 TCP,默认服务端口号 53。􏰂
6. FTP(FileTransferProtocol,文件传输协议)是用来进行文件传输的标准协议。 FTP 基于 TCP 使用端口号 20 来传输数据,21 来传输控制信息。
7. SSH(SecureShell,安全Shell),因为传统的网络服务程序比如TELNET本质上都极不安全,明文传说数据和用户信息包括密码,SSH 被开发出来避免这些问题, 它其实是一个协议框架,有大量的扩展冗余能力,并且提􏰁供了加密压缩的通道可以为其他协议使用。
8. POP(PostOfficeProtocol,邮局协议)是支持通过客户端访问电子邮件的服务, 现在版本是 POP3,也有加密的版本 POP3S。协议使用 TCP,端口 110。
9. SMTP(Simple Mail Transfer Protocol,简单邮件传输协议)是现在在互联网 上发送电子邮件的事实标准。使用 TCP 协议传输,端口号 25。
10. HTTP(HyperTextTransferProtocol,超文本传输协议)是现在广为流行的WEB 网络的基础,HTTPS 是 HTTP 的加密安全版本。协议通过 TCP 传输,HTTP 默认使用端口 80,HTTPS 使用 443。




### 1.3 TCP/IP五层模型

在了解了OSI七层模型之后，再来看看五层模型。TCP/IP五层模型的协议分为：应用层、传输层、网络层、数据链路层和物理层。

![tcp:ip5.jpg](http://upload-images.jianshu.io/upload_images/3261360-ad69a950b4dc5c71.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<br>

## 2. 传输控制协议（TCP）&& 用户数据报协议（UDP）

TCP全称是Transmission Control Protocol，传输控制协议。上文提到了，它可以提供可靠的、面向连接的网络数据传递服务。

> 面向连接的网络服务又称为虚电路（Virtual Circuit）服务，它具有网络连接建立、数据传输和网络连接释放三个阶段。是按顺序传输可靠的报文分组方式，适用于指定对象、长报文、会话型传输要求。
> 面向连接服务以电话系统为模式。要和某个人通话，首先拿起电话，拨号码，通话，然后挂断。同样在使用面向连接的服务时，用户首先要建立连接，使用连接，然后释放连接。连接本质上像个管道：发送者在管道的一端放入物体，接收者在另一端按同样的次序取出物体；其特点是收发的数据不仅顺序一致，而且内容也相同。--类似打电话



### 2.1 功能：

- 对程序发送的大块数据进行分段和重组。
- 确保正确排序及按顺序传递分段的数据。
- 通过计算校验和，进行传输数据的完整性检查。
- 根据数据是否接收成功发送肯定消息。通过使用选择性确认，也对没有收到的数据发送否定确认。



###2.2 工作原理 

TCP的连接建立过程称为TCP三次握手。

- **首先发送方主机向接收方主机发起一个建立连接的同步（SYN）请求；**
- **接收方主机在收到这个请求后向发送方主机回复一个同步/确认（SYN/ACK）应答；**
- **发送方主机收到此包后再向接收方主机发送一个确认（ACK），此时TCP连接成功建立.**

一旦初始的三次握手完成，在发送和接收主机之间将按顺序发送和确认段。关闭连接之前，TCP使用类似的握手过程验证两个主机是否都完成发送和接收全部数据。完成三次握手，客户端与服务器开始传送数据。



说明：

- TCP重置：TCP允许在传输的过程中突然中断连接。
- TCP数据排序和确认：在传输的过程中使用序列号和确认号来跟踪数据的接收情况。
- TCP延迟确认：TCP并不总是在接收到数据后立即对其进行确认，它允许主机在接收数据的同时发送自己的确认信息给对方。
- TCP数据保护（校验）：TCP是可靠传输的协议，它提供校验和计算来实现数据在传输过程中的完整性。
- TCP重传：在TCP的传输过程中，如果在重传超时时间内没有收到接收方主机对某数据包的确认回复，发送方主机就认为此数据包丢失，并再次发送这个数据包给接收方。
- TCP连接关闭：发送方主机和目的主机建立TCP连接并完成数据传输后，会发送一个将结束标记置1的数据包，以关闭这个TCP连接，并同时释放该连接占用的缓冲区空间。




<br>

###2.3 用户数据报协议（UDP） 

> UDP全称是User Datagram Protocol，中文名为用户数据报协议。UDP 提供无连接的网络服务，该服务对消息中传输的数据提供不可靠的、最大努力传送。这意味着它不保证数据报的到达，也不保证所传送数据包的顺序是否正确。



对比：

- UPD（用户数据报协议）
  - 只管发送，不确认对方是否收到
  - 将数据及源和目的封装成数据包，不需要建立连接
  - 每个数据包的大小限制在 64k 之内
  - 因为无需连接，所以是不可靠
  - 不需要建立连接，速度快
  - 应用场景：网络视频播放、游戏
- TCP（传输控制协议）
  - 建立连接，形成传输数据的通道
  - 在连接中进行大数据传输（数据大小不受限制）
  - 通过三次握手完成连接，是可靠协议，安全送达
  - 必须建立连接，效率会稍低
  - TCP 连接`三次握手`



UDP：面向非连接、传输不可靠、用于传输少量数据(数据报模式)、速度快。

TCP：面向连接、传输可靠(保证数据正确性,保证数据顺序)、用于传输大量数据(流模式)、速度慢，建立连接需要开销较多(时间，系统资源)。



#### **基本TCP客户—服务器程序设计基本框架**

![tcp.jpg](http://upload-images.jianshu.io/upload_images/3261360-add512ed437b7ad1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### **基本UDP客户—服务器程序设计基本框架流程图**

![udp.jpg](http://upload-images.jianshu.io/upload_images/3261360-249efcd61a4406d9.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



TCP和UDP都是IP层面的传输协议，是IP与上层之间的处理接口。TCP和UDP端口号被设计来区分运行在单个设备上的多重应用程序的IP地址。由于同一台计算机上可能会运行多个网络应用程序，所以计算机需要确保目标计算机上接收源主机数据包的软件应用程序的正确性，以及响应能够被发送到源主机的正确应用程序上。该过程正是通过使用TCP或UDP端口号来实现的。**即每一个应用都会在网卡上注册一个端口号用来区分同一台设备上应用的之间的通信。**

![structure.png](http://upload-images.jianshu.io/upload_images/3261360-6d05945f36cdbaaa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 在TCP和UDP头部分，有“源端口”和“目标端口”段，主要用于显示发送和接收过程中的身份识别信息。IP 地址和端口号合在一起被称为“套接字”。TCP端口比较复杂，其工作方式与UDP端口不同。UDP端口对于基于UDP的通信作为单一消息队列和网络端点来操作，而所有TCP通信的终点都是唯一的连接。每个TCP连接由两个端点唯一识别。由于所有TCP连接由两对 IP 地址和TCP端口唯一识别（每个所连主机都有一个地址/端口对），因此每个TCP服务器端口都能提供对多个连接的共享访问



<br>

## 3. Socket

> Socket 是应用层与TCP/IP协议族通信的中间软件抽象层，它是一组接口。用 Socket 能够实现网络上的不同主机之间或同一主机的不同对象之间的数据通信。所以,现在 Socket 已经是一类通用通信接口的集合。大的类型可以分为网络 Socket 和本地 Socket 两种。

IP层的ip地址可以唯一标示主机，而TCP层协议和端口号可以唯一标示主机的一个进程，所以可以利用ip地址＋协议＋端口号唯一标示网络中的一个进程。总结下来，socket通信需要五个条件：连接使用的协议，本地主机的IP地址，本地进程的协议端口，远地主机的IP地址，远地进程的协议端口。

Socket通信就是一种确定了端口号的TCP/IP通信，或者说Socket通信与IP通信差别就是端口确定，协议确定。Socket可以支持不同的传输层协议（TCP或UDP），当使用TCP协议进行连接时，该Socket连接就是一个TCP连接,UDP连接同理。

**Socket是对TCP/IP协议的封装，Socket本身并不是协议，而是一个调用接口（API），通过Socket，我们才能使用TCP/IP协议**。

我们在传输数据时，可以只使用传输层（TCP/IP），但是那样的话，由于没有应用层，便无法识别数据内容，如果想要使传输的数据有意义，则必须使用应用层协议，应用层协议很多，有HTTP、FTP、TELNET等等，也可以自己定义应用层协议。WEB使用HTTP作传输层协议，以封装HTTP文本信息，然后使用 TCP/IP 做传输层协议将它发送到网络上。Socket是对 TCP/IP 协议的封装，Socket 本身并不是协议，而是一个调用接口（API），通过Socket，我们才能使用TCP/IP 协议。



![socket.png](http://upload-images.jianshu.io/upload_images/3261360-9e0ca84fac35b4b3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

建立Socket连接至少需要一对套接字，其中一个运行于客户端，称为ClientSocket，另一个运行于服务器端，称为ServerSocket。套接字之间的连接过程分为三个步骤：服务器监听，客户端请求，连接确认。

如下图，socket的连接步骤：

1. 创建客户端Socket
2. 创建服务器Socket
3. 连接到服务器(Socket编程)
4. 发送数据给服务器
5. 接收服务器返回的数据
6. 关闭Socket : close(socketNumber)

![socketuserflow.png](http://upload-images.jianshu.io/upload_images/3261360-456687d1e557a058.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```objective-c
1.  导入头文件
#import <sys/socket.h> //socket相关
#import <netinet/in.h>  //internet相关
#import <arpa/inet.h>   //地址解析协议相关
2. socket(创建)
     int socket(int, int, int);
    /**
     参数
     第一个int：domain:    协议域，AF_INET（IPV4的网络开发）
     第二个int：type:      Socket 类型，  SOCK_STREAM(TCP)/SOCK_DGRAM(UDP，报文)
     第三个int：protocol:  IPPROTO_TCP，协议，如果输入0，可以根据第二个参数，自动选择协议
     返回值
     socket，如果 > 0 就表示成功
     */
3. connection (连接到“服务器)
    connect(int, const struct sockaddr *, socklen_t)
    /**
     参数
     1> 客户端socket
     2> 指向数据结构sockaddr的指针，其中包括目的端口和IP地址
        服务器的"结构体"地址，C语言没有对象
     3> 结构体数据长度
     返回值
     0 成功/其他 错误代号
     */
4. write(发送数据)
    send(int, const void *, size_t, int)
    /**
     参数
     1> 客户端socket
     2> 发送内容地址 void * == id
     3> 发送内容长度
     4> 发送方式标志，一般为0
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
      */
5. read (接收)
    recv(int, void *, size_t, int)
    /**
     参数
     第一个int :创建的socket
     void *：接收内容的地址
     size_t：接收内容的长度
     第二个int.：接收数据的标记 0，就是阻塞式，一直等待服务器的数据 
     返回值
     接收到的数据长度
     */
6. close
    close(int);
    int:就是创建的socket

```

> 此时没有写服务端，怎么测试？
> 可利用：nc -lk 端口号:始终监听本地计算机此端口的数据。
> eg：nc -lk 6666；
> 操作步骤gif
> 1、监听 6666端口
> 2、connettion；
> 3、发送socket；服务器接收到socket；
> 4、服务端send ：hello socket；



另，可使用[CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket)简化开发，且其支持TCP和UDP，TCP是流的形式，UDP是数据报形式。

```objective-c
- (IBAction)connectToServer:(id)sender {
// 1.与服务器通过三次握手建立连接
NSString *host = @"133.33.33.1";
int port = 1212;

//创建一个socket对象
_socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

//连接
NSError *error = nil;
[_socket connectToHost:host onPort:port error:&error];

if (error) {
    NSLog(@"%@",error);
}
}


#pragma mark -socket的代理
#pragma mark 连接成功
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
NSLog(@"%s",__func__);
}


#pragma mark 断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
if (err) {
    NSLog(@"连接失败");
}else{
    NSLog(@"正常断开");
}
}


#pragma mark 数据发送成功
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
NSLog(@"%s",__func__);

//发送完数据手动读取，-1不设置超时
[sock readDataWithTimeout:-1 tag:tag];
}

#pragma mark 读取数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
NSString *receiverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
NSLog(@"%s %@",__func__,receiverStr);
}

```


