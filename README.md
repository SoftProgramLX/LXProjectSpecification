# LXProjectSpecification

前沿：整理了一个项目开发基础，涉及到开发初期的必备条件。源码请点击[github地址](https://github.com/SoftProgramLX?tab=repositories)下载。

##目录
* 一.[封装网络请求](#封装网络请求) 
* 二.[json转model](#json转model) 
* 三.[方法顺序](#方法顺序) 
* 四.[四.文件结构](#文件结构) 
* 五.[UITableView自动布局](#UITableView自动布局) 
* 六.[UITableViewHeaderFooterView复用](#UITableViewHeaderFooterView复用) 
* 七.[计算文本内容大小](#计算文本内容大小) 

封装网络请求
-----------

####1.封装get请求
```
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
```

  2.封装post请求
```
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
```
3.使用方法
```
[LXNetWorkTool get:urlStr param:param success:^(NSDictionary *responseDic) {

NSLog(@"%@", responseDic);

} failure:^(NSError *error) {

}];
```

json转model
-----------

获取到网络json数据后，无论多么复杂的数据结构，嵌套多少层，使用mj的一个第三方一句代码将字典转化成model，如下：
```
LXStockResult *resultModel = [LXStockResult objectWithKeyValues:responseDic];
```
但是必须先根据responseDic的数据结构定义好在LXStockResult的属性列表，如这样的数据结构：
![screen1.png](http://upload-images.jianshu.io/upload_images/301102-8c7b8406bdeaa47a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
需创建的model文件如下：
![screen2.png](http://upload-images.jianshu.io/upload_images/301102-14202d837962f7b3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
对应的属性列表如下：
```
@interface LXStockResult : NSObject
@property (nonatomic, strong) LXStockResponse *response;
@end

@interface LXStockResponse : NSObject
@property (nonatomic, strong) LXStockResponseStatus *responseStatus;
@property (nonatomic, strong) NSArray *stockList;
@end
@implementation LXStockResponse
+ (NSDictionary *)objectClassInArray
{
    return @{@"stockList":[LXStockList class]};
}
@end

@interface LXStockResponseStatus : NSObject
@property (nonatomic, copy)   NSString *status;
@property (nonatomic, copy)   NSString *statusInfo;
@end

@interface LXStockList : NSObject
@property (nonatomic, copy)   NSString *stockCode;
@property (nonatomic, copy)   NSString *stockName;
@end

```

方法顺序
-----------

```
#pragma mark - Life cycle
#pragma mark - Init data
#pragma mark - Loading data
#pragma mark - Create view
#pragma mark - UITableViewDelegate
#pragma mark - SystemDelegate
#pragma mark - CustomDelegate
#pragma mark - Observer
#pragma mark - Enent response
#pragma mark - Private methods
#pragma mark - Setter and getter
```
将方法顺序整理，利于快速查找方法，易于后期维护
展示效果如图：
![screen4.png](http://upload-images.jianshu.io/upload_images/301102-111a829f090094a3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

文件结构
-----------

如下图：
![screen3.png](http://upload-images.jianshu.io/upload_images/301102-987d149d8f3d2459.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
有一个清晰的文件结构，利于理解业务与后期维护。

##五.UITableView自动布局
```
[LXNetWorkTool get:urlStr param:param success:^(NSDictionary *responseDic) {
    LXStockResult *resultModel = [LXStockResult objectWithKeyValues:responseDic];
    //这里将stockList模型数组再封装，通过model的数据与cell控件结合算出文本高。
    [self.showDataArr setArray:[self manageViewsFrameWithDatas:resultModel.response.stockList]];
    [self.tableView reloadData];
} failure:^(NSError *error) {
}];
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

- (void)configurationCell:(LXTestStockFrame *)frameModel;
{
    self.stockNameLabel.frame = frameModel.stockNameLabelFrame;
    self.stockNameLabel.text = frameModel.model.stockName;
    
    self.stockCodeLabel.frame = frameModel.stockCodeLabelFrame;
    self.stockCodeLabel.text = frameModel.model.stockCode;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXTestStockFrame *frame = self.showDataArr[indexPath.row];
    return frame.cellHeight;
}
```

UITableViewHeaderFooterView复用
-----------

若UITableViewHeaderFooterView不采用复用机制，那么每次滑动TableView看见HeaderFooterView时都会掉用下面的代理方法从而不断重复创建
```
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LXTestHeaderView *headerView = [LXTestHeaderView headerViewWithTableView:tableView];
    return headerView;
}

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
```

计算文本内容大小
-----------

####1.计算普通文本的高
```
+ (CGFloat)calculateLabelighWithText:(NSString *)textStr withMaxSize:(CGSize)maxSize withFont:(CGFloat)font
{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGSize actualSize = [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return actualSize.height;
}
```
####2.计算富文本的高
```
#define GetLabelNormalHeight(height,font,spaceH) (height + (height - [UIFont systemFontOfSize:font].pointSize)*(spaceH>0 ? spaceH : 0.3))
/**
 *@param textStr 富文本的string属性的值
 *@param maxSize 控件所需最大空间，一般高是最大值，如：CGSizeMake(stockNameLabelW, MAXFLOAT)
 *@param font 字体大小
 *@param spaceRH label行距占行高的比例，一般值为0.3
 */
+ (CGFloat)calculateLabelighWithText:(NSString *)textStr withMaxSize:(CGSize)maxSize withFont:(CGFloat)font withSpaceRH:(CGFloat)spaceRH
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGRect rect = [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return GetLabelNormalHeight(rect.size.height, font, spaceRH);
}
```

<br>
<br>
###QQ:2239344645    [我的github](https://github.com/SoftProgramLX?tab=repositories)
<br>
