//
//  UIImage+TTImage.m
//  NSURLSessionNetTools
//
//  Created by Thinkive on 2017/11/20.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import "UIImage+TTImage.h"

@implementation UIImage (TTImage)


/**
 根据传入imageName获取图形上下文
 
 @param imageName imageName
 @return image
 */
+ (nullable UIImage *)tt_drawImageWithImageName:(nullable NSString *)imageName{
    //1.获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
    //2.开启图形上下文
    UIGraphicsBeginImageContext(image.size);
    //3.绘制到图形上下文中
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //4.从上下文中获取图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


/**
 给图片添加水印
 
 @param image 源图片
 @param waterImage 水印图片
 @param rect 范围
 @return image
 */
+ (nullable UIImage *)tt_watermarkWithImage:(nullable UIImage *)image waterImage:(nullable UIImage *)waterImage waterImageRect:(CGRect)rect{
    
    //1.获取图片
    
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //4.从上下文中获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


/**
 给图片添加文字水印
 
 @param image 源图片
 @param text 水印文字
 @param point 位置
 @param attributed 属性
 @return image
 */
+ (nullable UIImage *)tt_watermarkWithImage:(UIImage *_Nullable)image text:(nullable NSString *)text textPoint:(CGPoint)point attributedString:(nullable NSDictionary< NSString *, id> *)attributed{
    //开始上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


/**
 图片裁剪成圆
 
 @param image 源图片
 @param rect 范围
 @return image
 */
+ (nullable UIImage *)tt_cornerRadiusWithImage:(nullable UIImage *)image circleRect:(CGRect)rect{
    
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2、设置裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
}


/**
 图片裁剪成圆并设置边框大小和颜色
 
 @param image 源图片
 @param rect 范围
 @param borderWidth 边框大小
 @param borderColor 边框颜色
 @return image
 */
+ (nullable UIImage *)tt_cornerRadiusWithImage:(UIImage *_Nullable)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nullable)borderColor{
    
    //    1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //    2.设置边框
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [borderColor setFill];
    [path fill];
    
    //    3.设置裁剪区域
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + borderWidth , rect.origin.x + borderWidth , rect.size.width - borderWidth * 2, rect.size.height - borderWidth *2)];
    [clipPath addClip];
    
    //    4.绘制图片
    [image drawAtPoint:CGPointZero];
    
    //    5.获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //    6.关闭上下文
    UIGraphicsEndImageContext();
    //    7.返回新图片
    return newImage;
}


/**
 指定截图带回调
 
 @param view 截屏view
 @param block 回调
 */
+ (void)tt_screenshotWithView:(nullable UIView *)view block:(void(^_Nullable)(UIImage * _Nullable image,NSData * _Nullable imagedata))block{
    
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //2.获取当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //3.截屏
    [view.layer renderInContext:contextRef];
    //4.获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.转化成为Data
    //compressionQuality:表示压缩比 0 - 1的取值范围
    NSData * data = UIImageJPEGRepresentation(newImage, 1);
    //6、关闭上下文
    UIGraphicsEndImageContext();
    block(newImage,data);
}


/**
 擦除
 
 @param view 操作view
 @param nowPoint 当前point
 @param size 大小
 @return image
 */
+ (nullable UIImage *)tt_wipeImageWithView:(nullable UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size{
    //计算位置
    CGFloat offsetX = nowPoint.x - size.width * 0.5;
    CGFloat offsetY = nowPoint.y - size.height * 0.5;
    CGRect clipRect = CGRectMake(offsetX, offsetY, size.width, size.height);
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //获取当前的上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //把图片绘制上去
    [view.layer renderInContext:contextRef];
    //把这一块设置为透明
    CGContextClearRect(contextRef, clipRect);
    //获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 自定义裁剪
 
 @param view 裁剪的view
 @param frame 裁剪区域
 @param block 回调
 */
+ (void)tt_clipView:(nullable UIView *)view cutFrame:(CGRect)frame block:(void(^_Nullable)(UIImage * _Nullable image,NSData * _Nullable imageData))block{
    
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    //2、获取当前的上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //3、添加裁剪区域
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:frame];
    [path addClip];
    //4、渲染
    [view.layer renderInContext:contextRef];
    //5、从上下文中获取
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7、关闭上下文
    UIGraphicsEndImageContext();
    
    NSData * data = UIImageJPEGRepresentation(newImage, 1);
    block(newImage,data);
    
}


//***********************************  设置圆角  ***********************************


- (UIImage *_Nullable)tt_drawRectWithRoundedCorner:(CGFloat)radius andSize:(CGSize)size{
    //1.设置rect
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //3.获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //4.设置裁剪区域  UIRectCornerAllCorners 为上下左右 根据radius初始化一个圆角矩形路径
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    //5.修改当前剪切路径
    CGContextClip(ctx);
    //5.绘制到图形上下文中
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//***********************************  图片压缩  ***********************************


/**
 *  图片的压缩方法
 *
 *  @param sourceImage   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+(UIImage *_Nullable)IMGCompressed:(UIImage *_Nullable)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        
        NSAssert(!newImage,@"图片压缩失败");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}




@end
