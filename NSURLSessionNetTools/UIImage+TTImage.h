//
//  UIImage+TTImage.h
//  NSURLSessionNetTools
//
//  Created by Thinkive on 2017/11/20.
//  Copyright © 2017年 Teo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TTImage)



/**
 根据传入imageName获取图形上下文
 
 @param imageName imageName
 @return image
 */
+ (nullable UIImage *)tt_drawImageWithImageName:(nullable NSString *)imageName;



/**
 给图片添加水印
 
 @param image 源图片
 @param waterImage 水印图片
 @param rect 范围
 @return image
 */
+ (nullable UIImage *)tt_watermarkWithImage:(nullable UIImage *)image waterImage:(nullable UIImage *)waterImage waterImageRect:(CGRect)rect;



/**
 给图片添加文字水印
 
 @param image 源图片
 @param text 水印文字
 @param point 位置
 @param attributed 属性
 @return image
 */
+ (nullable UIImage *)tt_watermarkWithImage:(UIImage *_Nullable)image text:(nullable NSString *)text textPoint:(CGPoint)point attributedString:(nullable NSDictionary< NSString *, id> *)attributed;



/**
 图片裁剪成圆
 
 @param image 源图片
 @param rect 范围
 @return image
 */
+ (nullable UIImage *)tt_cornerRadiusWithImage:(nullable UIImage *)image circleRect:(CGRect)rect;



/**
 图片裁剪成圆并设置边框大小和颜色
 
 @param image 源图片
 @param rect 范围
 @param borderWidth 边框大小
 @param borderColor 边框颜色
 @return image
 */
+ (nullable UIImage *)tt_cornerRadiusWithImage:(UIImage *_Nullable)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nullable)borderColor;



/**
 指定截图带回调
 
 @param view 截屏view
 @param block 回调
 */
+ (void)tt_screenshotWithView:(nullable UIView *)view block:(void(^_Nullable)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;



/**
 擦除
 
 @param view 操作view
 @param nowPoint 当前point
 @param size 大小
 @return image
 */
+ (nullable UIImage *)tt_wipeImageWithView:(nullable UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size;



/**
 自定义裁剪
 
 @param view 裁剪的view
 @param frame 裁剪区域
 @param block 回调
 */
+ (void)tt_clipView:(nullable UIView *)view cutFrame:(CGRect)frame block:(void(^_Nullable)(UIImage * _Nullable image,NSData * _Nullable imageData))block;


//***********************************  设置圆角  ***********************************

/**
 添加圆角
 
 @param radius radius
 @param size size
 @return image
 */
- (UIImage *_Nullable)tt_drawRectWithRoundedCorner:(CGFloat)radius andSize:(CGSize)size;



//***********************************  图片压缩  ***********************************


/**
 *  图片的压缩方法
 *
 *  @param sourceImage   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+(UIImage *_Nullable)IMGCompressed:(UIImage *_Nullable)sourceImage targetWidth:(CGFloat)defineWidth;


@end
