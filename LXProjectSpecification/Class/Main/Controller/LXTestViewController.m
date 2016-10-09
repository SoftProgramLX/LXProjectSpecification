//
//  LXTestViewController.m
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXTestViewController.h"
#import "LXTestTableCell.h"
#import "LXStockResult.h"
#import "LXTestStockFrame.h"
#import "LXTestHeaderView.h"

@interface LXTestViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak)   UITableView *tableView;
@property (nonatomic, copy)   NSMutableArray *showDataArr;

@end

@implementation LXTestViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bgColor;
    
    [self initData];
    [self createUI];
    [self downloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:YES];
}

- (void)dealloc
{
    
}

#pragma mark - Init data

- (void)initData
{
    _showDataArr = [NSMutableArray array];
}

#pragma mark - Loading data

- (void)downloadData
{
    NSString *param = @"";//在这里拼接参数
    NSString *urlStr = @"https://www.baidu.com";
    
    [LXNetWorkTool get:urlStr param:param success:^(NSDictionary *responseDic) {
        NSLog(@"%@", responseDic);
        
    } failure:^(NSError *error) {
#warning 这个请求肯定不成立返回错误，只是一个例子。下面我从本地json文件获取数据模拟从网络请求的操作过程
        NSDictionary *responseDic = [LXHelpClass getTestFileContent];
#warning 正常的请求是从下面这行代码开始，并且得到的数据responseDic会在上面的success^block返回，所以将下面的代码剪切到上面的成功block里就好了
        
        //使用第三方一行代码将整个数据结构转化为了一个model，将会用model的属性取值替代在字典里用key取值。
        LXStockResult *resultModel = [LXStockResult objectWithKeyValues:responseDic];
        //判断服务器返回“1200”是正常才做业务处理
        if ([resultModel.response.responseStatus.status isEqualToString:@"1200"]) {
            //这里将stockList模型数组再封装，通过model的数据与cell控件结合算出文本高。
            [self.showDataArr setArray:[self manageViewsFrameWithDatas:resultModel.response.stockList]];
            [self.tableView reloadData];
        } else {
            //服务器返回错误了，在这里可以做一些提醒处理
        }
    }];
}

#pragma mark - Create view

- (void)createUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    tableView.backgroundColor = bgColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 0
    LXTestTableCell *cell = [LXTestTableCell cellWithTableView:tableView];
    cell.row = indexPath.row;
    [cell configurationCell:self.showDataArr[indexPath.row]];
    return cell;
    
#else
    //如果有多种样式的cell，则可以根据区别indexPath.section或indexPath.row去创建不同的cell
    if (indexPath.section == 0) {
        LXTestTableCell *cell = [LXTestTableCell cellWithTableView:tableView];
        cell.row = indexPath.row;
        [cell configurationCell:self.showDataArr[indexPath.row]];
        return cell;
    } else {
        LXTestTableCell *cell = [LXTestTableCell cellWithTableView:tableView];
        cell.row = indexPath.row;
        [cell configurationCell:self.showDataArr[indexPath.row]];
        return cell;
    }
#endif
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[LXTestViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showDataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXTestStockFrame *frame = self.showDataArr[indexPath.row];
    return frame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LXTestHeaderView *headerView = [LXTestHeaderView headerViewWithTableView:tableView];
    return headerView;
}

#pragma mark - SystemDelegate



#pragma mark - CustomDelegate



#pragma mark - Observer



#pragma mark - Enent response



#pragma mark - Private methods

- (NSArray *)manageViewsFrameWithDatas:(NSArray *)datas
{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (LXStockList *listModel in datas) {
        LXTestStockFrame *frame = [[LXTestStockFrame alloc] init];
        frame.model = listModel;
        [tempArr addObject:frame];
    }
    return tempArr;
}

#pragma mark - Setter and getter


@end



