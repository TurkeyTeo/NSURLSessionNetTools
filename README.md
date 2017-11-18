## 1. NSURLConnection

当我们使用NSURLConnection进行普通网络请求时，代码如下：

```objective-c
    NSString *urlString = @"XXX" ;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (!connectionError) {
            NSObject *obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@",obj);
        }
    }];
```

基本步骤：

1. 创建一个NSURL对象，设置请求路径
2. 传入NSURL并创建一个NSURLRequest对象，设置请求头和请求体
3. 使用NSURLConnection发送请求



对于复杂些的业务，我们可以设置代理，然后在对应的代理方法中处理数据。

```objective-c
//第三个参数:startImmediately :是否立即开始发送网络请求
NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
```

```objective-c
//    1、当接受到服务器响应的时候会调用:response(响应头)
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
//    2、当接受到服务器返回数据的时候调用(会调用多次)
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
//    3、当请求失败的时候调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
//    4、当请求结束(成功|失败)的时候调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

```


<br>


## 2. NSURLSession

实际上NSURLSession是对NSURLConnection进行重构优化之后的网络接口。

如下图，NSURLSession由NSURLSessionConfiguration和可选代理(optional delegate)构成。

![construct.png](http://upload-images.jianshu.io/upload_images/3261360-e2d2ecf056b153e9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

NSURLSession 针对普通、上传和下载分别对应四种不同的网络请求任务：NSURLSessionDataTask， NSURLSessionUploadTask和NSURLSessionDownloadTask以及NSURLSessionStreamTask（以流的形式使用较少，是针对直接进行TCP/IP连接的网络操作API，代替NSInputStream和NSOutputStream）

![relationship.png](http://upload-images.jianshu.io/upload_images/3261360-359bba545e5c83cf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**创建的task都是挂起状态，需要resume才能启动。**

通常使用NSURLSession也分为3步：

1. 创建NSURLSession对象

2. 通过 NSURLSession 的实例创建 Task

3. 执行 Task

   ​

### 2.1 NSURLSessionConfiguration

1. **defaultSessionConfiguration**  - 使用全局的cache,cookie和credential storage objects来创建configuration对象。    
2. **ephemeralSessionConfiguration** – 这个configuration用于“private” sessions，还有对于cache, cookie, or credential storage objects的非永久存储。
3. **backgroundSessionConfiguration** – 做远程push通知或是应用程序挂起的时候就要用到这个configuration。


<br>

### 2.2 NSURLSession

1. 对于默认获取的session对象：NSURLSession *session = [NSURLSession sharedSession]

   ```objective-c
   /*
    * 用于基本的网络请求，可以几行代码就获取 URL 的内容，使用简单
    * 无法不断的获取服务器返回的数据
    * 无法修改默认的连接行为
    * 身份验证的能力有限
    * 任务在后台时无法上传和下载
    */
   + (NSURLSession *)sharedSession;
   ```

2. 对于自定义的session对象

   ```objective-c
    // 不用代理
   + (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration;
   // 用代理
   + (NSURLSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(nullable id <NSURLSessionDelegate>)delegate delegateQueue:(nullable NSOperationQueue *)queue;
   ```

   ​
### 2.3 URLSessionTask

NSURLSessionTask是一个抽象类，我们使用的是他的4个子类。

NSURLSession比NSURLConnection最方便的地方就是任务可以暂停，继续。在网络请求中，真正去执行下载或者上传任务的就是URLSessionTask，我们来看一下它常用的方法：

`- (void)resume;` 当使用NSURLSession创建一个NSURLSessionTask任务时，要手动调用此方法，任务才会开启，而NSURLConnection默认开启。

`- (void)suspend;` 暂停任务方法，手动调用会暂停当前任务，再次开启此任务时，会从紧接上次任务开始，会面会说到如何暂停任务再开启任务。

`- (void)cancel;` 取消任务。

另外`NSURLSessionTaskState state;` 属性能够获取到当前任务的状态

```
typedef NS_ENUM(NSInteger, NSURLSessionTaskState) {
    NSURLSessionTaskStateRunning = 0,                     /* 正在执行 */
    NSURLSessionTaskStateSuspended = 1,                   /* 暂停状态 */
    NSURLSessionTaskStateCanceling = 2,                   /* 取消状态*/
    NSURLSessionTaskStateCompleted = 3,                   /* 任务完成状态 */
}
```



#### <br>

#### 2.3.1 NSURLSessionDataTask

通常我们都是使用的NSURLSessionDataTask来进行GET和POST请求。基本上和NSURLConnection一样，在block中解析返回数据。



如下就是一个简单的**GET**请求。


对于普通网络请求，不需要指定运行哪个队列，默认会开辟一个后台线程：

```objective-c
    NSString *urlString = @"XXX";
    NSURLSession *session = [NSURLSession sharedSession];
	//NSURLSessionDataTask
    [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // handle response
    }] resume];
```

<br>

**POST**

```objective-c
/**
 *  简单 Post 请求，POST 和 GET 请求在于对 request 的处理不同，其余和 GET 相同
 */
- (void)postWithSharedSession
{
  // 获取默认 Session
  NSURLSession *session = [NSURLSession sharedSession];
  // 创建 URL
  NSURL *url = [NSURL URLWithString:@"XXX"];
  // 创建 request
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  // 请求方法
  request.HTTPMethod = @"POST";
  // 请求体
  request.HTTPBody = [@"username=1234&pwd=4321" dataUsingEncoding:NSUTF8StringEncoding];
  // 创建任务 task
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          // 获取数据后解析并输出
          NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
  }];
  // 启动任务
  [task resume];
}
```

<br>

**Delegate形式**：

```objective-c
//创建有代理的session
- (void)doSessionDelegate{
    // 1.创建带有代理方法的自定义 session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // 2.创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"XXXXXX"]]];
    
    // 3.启动任务
    [task resume];
}

#pragma mark - NSURLSessionDelegate
// 1. 接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"接收到服务器的响应");
    // 必须设置对响应进行允许处理才会执行后面两个操作。
    completionHandler(NSURLSessionResponseAllow);
}

// 2. 接收到服务器的数据（可能调用多次）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 处理每次接收的数据
    NSLog(@"接受到服务器的数据%s",__func__);
}

// 3. 请求成功或者失败（如果失败，error有值）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
    NSLog(@"SessionTask %s",__func__);
}

```

<br>

#### 2.3.2 NSURLSessionDownloadTask 文件下载

1. 普通下载

```objective-c

//******************* NSURLSessionDownloadTask 文件下载 ********************

- (void)doNSURLSessionDownloadTask{
    // 1.创建url
    NSString *urlString = [NSString stringWithFormat:@"http://XXXX.mp3"];
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];

    // 2.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3.创建会话，采用苹果提供全局的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.创建任务
    NSURLSessionDownloadTask *downloadTask = [sharedSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            // location:下载任务完成之后,文件存储的位置，这个路径默认是在tmp文件夹下!
            // 只会临时保存，因此需要将其另存
            NSLog(@"location:%@",location.path);
            
            // 采用模拟器测试，为了方便将其下载到Mac桌面
            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            NSString *filePath = @"/Users/userName/Desktop/XXXX.mp3";
            NSError *fileError;
            [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:filePath error:&fileError];
            if (fileError == nil) {
                NSLog(@"file save success");
            } else {
                NSLog(@"file save error: %@",fileError);
            }
        } else {
            NSLog(@"download error:%@",error);
        }
    }];
    
    // 5.开启任务
    [downloadTask resume];
}
```

<br>

2. 断点续传

几个用的知识点：

**Range**：需要续传的起始位置及长度。

```objective-c
在HTTP1.1协议（RFC2616）中定义了断点续传相关的HTTP头的Range和Content-Range字段，一个最简单的断点续传实现大概如下： 
客户端下载一个1024K的文件，已经下载了其中512K 
网络中断，客户端请求续传，因此需要在HTTP头中申明本次需要续传的片段：
  Range:bytes=512000-
这个头通知服务端从文件的512K位置开始传输文件 
服务端收到断点续传请求，从文件的512K位置开始传输，并且在HTTP头中增加：
Content-Range:bytes 512000-/1024000
并且此时服务端返回的HTTP状态码应该是206，而不是200。
```

 

**Content-length**: 即需要下载的文件字节数。 

```
Content-Length用于描述HTTP消息实体的传输长度the transfer-length of the message-body。在HTTP协议中，消息实体长度和消息实体的传输长度是有区别，比如说gzip压缩下，消息实体长度是压缩前的长度，消息实体的传输长度是gzip压缩后的长度。
```

注：**总字节数 = 已下载字节数 + content-length**  ， 我们可以在回调中拿到：

```objective-c
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
   // 拿到文件总大小 获得的是当次请求的数据大小，当我们关闭程序以后重新运行，开下载请求的数据是不同的 ,所以要加上之前已经下载过的内容 
   // [response.allHeaderFields[@"Content-Length"] integerValue]
  self.totalLength = response.expectedContentLength + self.currentLength;
 }
```



**Stream**： 流，它是对我们读写文件的一个抽象,是把文件的内容，一小段一小段的读出或写入。

- NSInputStream
  NSInputStream 对应的是读文件，所以要记住它是要将文件的内容读到内存(你声明的一段buffer)里
- NSOutputStream
  NSOutputStream 对应的是写文件，它是要将已存在的内存(buffer)里的数据写入文件


具体代码参见底下Demo。

<br>


#### 2.3.3 NSURLSessionUploadTask 文件上传 

1. 上传data：

```objective-c
    NSURL *textFileURL = [NSURL fileURLWithPath:@"/path/to/file.txt"];
    NSData *data = [NSData dataWithContentsOfURL:textFileURL];
    
    NSURL *url = [NSURL URLWithString:@"https://www.example.com/"];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    mutableRequest.HTTPMethod = @"POST";
    [mutableRequest setValue:[NSString stringWithFormat:@"%lld", data.length] forHTTPHeaderField:@"Content-Length"];
    [mutableRequest setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionUploadTask *uploadTask = [[NSURLSession sharedSession] uploadTaskWithRequest:mutableRequest fromData:data];
    [uploadTask resume];
```

<br>

2. 上传文件stream:

```objective-c
NSURL *textFileURL = [NSURL fileURLWithPath:@"/path/to/file.txt"];
 
NSURL *url = [NSURL URLWithString:@"https://www.example.com/"];
NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
mutableRequest.HTTPMethod = @"POST";
mutableRequest.HTTPBodyStream = [NSInputStream inputStreamWithFileAtPath:textFileURL.path];
[mutableRequest setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
[mutableRequest setValue:[NSString stringWithFormat:@"%lld", data.length] forHTTPHeaderField:@"Content-Length"];
 
NSURLSessionUploadTask *uploadTask = [defaultSession uploadTaskWithStreamedRequest:mutableRequest];
[uploadTask resume];
```

<br>

3. 我们来看看一个真实的上传栗子：

```objective-c

//******************* NSURLSessionDownloadTask 文件上传 ********************

- (void)doNSURLSessionUploadTask{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/2/statuses/public_timeline.json"]];
    //设置HTTP请求方式  GET / POST
    [request setHTTPMethod:@"POST"];
    //设置请求头
    NSString *boundary = @"yy";
    [request setValue:[NSString stringWithFormat: @"multipart/form-data;%@", boundary]forHTTPHeaderField:@"Content-type"];
    //设置请求体
    //获取上传的图片的data
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"my_sel@2x" ofType:@"png"]];
    NSData *body =  [self httpFormDataBodyWithBoundary:boundary params:@{@"access_token":@"2.00cYYKWF6EKpiB3883361b1dJiZ4eD",@"status":@"测试NSURLSession上传文件的微博"} fieldName:@"pic" fileName:@"pic.png" fileContentType:@"image/png" data:data];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *upload_task = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"upload  success");
    }];
    //必须要 resume
    [upload_task resume];

}


#pragma mark-拼接请求体
- (NSData *)httpFormDataBodyWithBoundary:(NSString *)boundary
                                  params:(NSDictionary *)params
                               fieldName:(NSString *)fieldName
                                fileName:(NSString *)fileName
                         fileContentType:(NSString *)fileContentType
                                    data:(NSData *)fileData {
    
    NSString *preBoundary = [NSString stringWithFormat:@"--%@",boundary];
    NSString *endBoundary = [NSString stringWithFormat:@"--%@--",boundary];
    NSMutableString *body = [[NSMutableString alloc] init];
    //遍历
    for (NSString *key in params) {
        //得到当前的key
        //如果key不是当前的pic，说明value是字符类型，比如name：Boris
        //添加分界线，换行，必须使用\r\n
        [body appendFormat:@"%@\r\n",preBoundary];
        //添加字段名称换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        
    }
    //添加分界线，换行
    [body appendFormat:@"%@\r\n",preBoundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",fieldName,fileName];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: %@\r\n\r\n",fileContentType];
    //声明结束符
    NSString *endStr = [NSString stringWithFormat:@"\r\n%@",endBoundary];
    //声明myRequestData，用来放入http  body
    NSMutableData *myRequestData = [NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:fileData];
    //加入结束符--yy--
    [myRequestData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
    return myRequestData;
}

```

<br>

## 3. 总结

1. NSURLConnection下载文件时，先是将整个文件下载到内存，然后再写入到沙盒，如果文件比较大，就会出现内存暴涨的情况。

   而使用NSURLSessionUploadTask下载文件，会默认下载到沙盒中的tem文件中，不会出现内存暴涨的情况，但是在下载完成后会把tem中的临时文件删除，需要在初始化任务方法时，在completionHandler回调中增加保存文件的代码。

2. NSURLConnection实例化对象，实例化开始，默认请求就发送(同步发送),不需要调用start方法。而cancel可以停止请求的发送，停止后不能继续访问，需要创建新的请求。

   NSURLSession有三个控制方法，取消(cancel)、暂停(suspend)、继续(resume)，暂停以后可以通过继续恢复当前的请求任务。

3. NSURLSessionConfiguration类的参数可以设置配置信息，其决定了cookie，安全和高速缓存策略，最大主机连接数，资源管理，网络超时等配置。NSURLConnection不能进行这个配置，相比较与NSURLConnection依赖与一个全局的配置对象，缺乏灵活性而言，NSURLSession有很大的改进。

4. NSURLSession支持后台上传下载任务。

   ​

   ​

   <br>

[Demo下载](https://github.com/TurkeyTeo/NSURLSessionNetTools)


