//
//  LXTestStockFrame.h
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/26.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXStockList.h"

@interface LXTestStockFrame : NSObject

//数据源
@property (nonatomic, strong) LXStockList *model;
//cell高
@property (nonatomic, assign) CGFloat cellHeight;
//stockNameLabel的坐标
@property (nonatomic, assign) CGRect stockNameLabelFrame;
//stockCodeLabel的坐标
@property (nonatomic, assign) CGRect stockCodeLabelFrame;

@end
