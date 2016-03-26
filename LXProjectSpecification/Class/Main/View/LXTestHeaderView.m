//
//  LXHeaderView.m
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/26.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXTestHeaderView.h"

@implementation LXTestHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *headerId = @"headerView";
    LXTestHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    
    if (headerView == nil) {
        headerView = [[LXTestHeaderView alloc] initWithReuseIdentifier:headerId];
    }
    
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = globalGrayColor;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        title.text = @"headerView也需要用复用池";
        title.textColor = globalRedWordColor;
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:18];
        [self addSubview:title];
    }
    return self;
}
//- (void)configurationHeaderView:(<#Model#> *)<#obj#>
//{
//
//}


@end
