//
//  LXTestStockFrame.m
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/26.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXTestStockFrame.h"

@implementation LXTestStockFrame

- (void)setModel:(LXStockList *)model
{
    _model = model;
    
    CGFloat stockNameLabelW = kScreenWidth - 2*globalAlignMargin;
    CGFloat stockNameLabelH = [LXHelpClass calculateLabelighWithText:model.stockName withMaxSize:CGSizeMake(stockNameLabelW, MAXFLOAT) withFont:18];
    self.stockNameLabelFrame = CGRectMake(globalAlignMargin, 12, stockNameLabelW, stockNameLabelH);
    
    CGFloat stockCodeLabelY = self.stockNameLabelFrame.origin.y + self.stockNameLabelFrame.size.height + 5;
    self.stockCodeLabelFrame = CGRectMake(self.stockNameLabelFrame.origin.x, stockCodeLabelY, 100, 12);
    
    self.cellHeight = self.stockCodeLabelFrame.origin.y + self.stockCodeLabelFrame.size.height + 12;
}

@end




