//
//  LXNetWorkTool.h
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/26.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNetWorkTool : NSObject

+ (void)post:(NSString *)url param:(NSString *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;
+ (void)get:(NSString *)url param:(NSString *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

@end
