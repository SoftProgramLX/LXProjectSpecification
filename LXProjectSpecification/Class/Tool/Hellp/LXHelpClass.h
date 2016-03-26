//
//  LXHellpClass.h
//  LXBaseConfigProject
//
//  Created by lx on 16/1/10.
//  Copyright © 2016年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface LXHelpClass : NSObject

+ (AppDelegate *)appDelegate;
+ (NSString*)devicePlatformString;
+ (NSString*)deviceString;
+ (NSDictionary *)getTestFileContent;
+ (CGFloat)calculateLabelighWithText:(NSString *)textStr withMaxSize:(CGSize)maxSize withFont:(CGFloat)font;

/**
 这是计算自定义行距的文本高度方法
 spaceRH是行距占文字高的比例，一般是0.2-0.3；
 */
+ (CGFloat)calculateLabelighWithText:(NSString *)textStr withMaxSize:(CGSize)maxSize withFont:(CGFloat)font withSpaceRH:(CGFloat)spaceRH;

@end



