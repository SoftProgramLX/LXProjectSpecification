//
//  LXTableViewCell.m
//  LXBaseConfigProject
//
//  Created by lx on 16/1/10.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "LXBaseCell.h"

@interface LXBaseCell ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation LXBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = cellBGColor;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = globalRedWordColor;
        
#if 0
        //设置背景颜色作为分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(globalAlignMargin, 0, kScreenWidth - 2*globalAlignMargin, 0.5)];
        lineView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
#else
        //图片作为分割线
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(globalAlignMargin, 0, kScreenWidth - 2*globalAlignMargin, 0.5)];
        lineImg.backgroundColor = [UIColor greenColor];
        lineImg.image = [UIImage imageNamed:@"my_topbg"];
        lineImg.hidden = NO;
        [self.contentView addSubview:lineImg];
        self.lineView = lineImg;
#endif
    }
    return self;
}

- (void)setRow:(NSInteger)row
{
    _row = row;
    if (row) {
        self.lineView.hidden = NO;
    } else {
        self.lineView.hidden = YES;
    }
}

@end







