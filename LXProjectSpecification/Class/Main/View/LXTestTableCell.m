//
//  LXTestTableCell.m
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXTestTableCell.h"

@interface LXTestTableCell ()

@property (nonatomic, weak)   UILabel *stockNameLabel;
@property (nonatomic, weak)   UILabel *stockCodeLabel;

@end

@implementation LXTestTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LXTestTableCell";
    LXTestTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LXTestTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = bgColor;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //UI控件属性采用weak修饰，创建时用局部变量赋给它
        UILabel *stockNameLabel = [[UILabel alloc] init];
        stockNameLabel.font = [UIFont systemFontOfSize:18];
        stockNameLabel.numberOfLines = 0;
        [self.contentView addSubview:stockNameLabel];
        self.stockNameLabel = stockNameLabel;
        
        UILabel *stockCodeLabel = [[UILabel alloc] init];
        stockCodeLabel.font = [UIFont systemFontOfSize:12];
        stockCodeLabel.numberOfLines = 0;
        [self.contentView addSubview:stockCodeLabel];
        self.stockCodeLabel = stockCodeLabel;
    }
    return self;
}

- (void)configurationCell:(LXTestStockFrame *)frameModel;
{
    self.stockNameLabel.frame = frameModel.stockNameLabelFrame;
    self.stockNameLabel.text = frameModel.model.stockName;
    
    self.stockCodeLabel.frame = frameModel.stockCodeLabelFrame;
    self.stockCodeLabel.text = frameModel.model.stockCode;
}

@end



