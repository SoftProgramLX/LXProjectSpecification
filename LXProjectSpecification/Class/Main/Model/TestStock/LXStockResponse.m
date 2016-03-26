//
//  ResponseModel.m
//  MJExtensionDemo
//
//  Created by 李旭 on 16/3/24.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXStockResponse.h"

@implementation LXStockResponse

+ (NSDictionary *)objectClassInArray
{
    return @{@"stockList":[LXStockList class]};
}

@end
