//
//  LXCreateView.h
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXCreateView : NSObject

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName selectedImg:(NSString *)selectedImgName target:(id)target action:(SEL)action;

@end
