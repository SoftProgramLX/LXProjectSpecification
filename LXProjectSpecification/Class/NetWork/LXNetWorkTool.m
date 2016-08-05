//
//  LXNetWorkTool.m
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/26.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXNetWorkTool.h"

@implementation LXNetWorkTool

+ (void)post:(NSString *)url param:(NSString *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/csv",@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [mgr POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObj) {
        if (success) {
            NSError *err;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:&err];
            
            if(err) {
                Log(@"json解析失败：%@",err);
            }
            success(responseDic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)get:(NSString *)url param:(NSString *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObj) {
        if (success) {
            NSError *error;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:&error];
            
            if(error) {
                Log(@"json解析失败：%@",error);
            }
            success(responseDic);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end




