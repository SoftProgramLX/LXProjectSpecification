//
//  LXTestTableCell.h
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXBaseCell.h"
#import "LXTestStockFrame.h"

@interface LXTestTableCell : LXBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)configurationCell:(LXTestStockFrame *)frameModel;

@end
