//
//  ContactTableViewController.m
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ContactTableViewController.h"
#import "Person.h"
#import "DetailsViewController.h"
#import "AddViewController.h"
#import "ContactCell.h"
#import "SearchResultController.h"

@interface ContactTableViewController ()<UITableViewDelegate,AddNewPerson>

@property (nonatomic,retain) NSMutableDictionary *dictionary;
@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,retain) UISearchController *searchController;

@end

@implementation ContactTableViewController

//设置重用标志
static NSString *identifier = @"myCellReuse";

//数据处理
- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        //获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"StudentInformation" ofType:@"plist"];
        //获取文件内容(字典)
        self.dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        //获取分组名
        self.array = [NSMutableArray arrayWithArray:[_dictionary allKeys]];
        //分组名排序
        [_array sortUsingSelector:@selector(compare:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //设置navigationBar的颜色和标题
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"所有联系人";
    //注册cell
    [self.tableView registerClass:[ContactCell class] forCellReuseIdentifier:identifier];
    //添加编辑按钮
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.title = @"编辑";
    //添加添加联系人按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewContact:)];
    //设置搜索控制器
    SearchResultController *search = [[SearchResultController alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:search];
    self.searchController.searchResultsUpdater = search;
    self.searchController.delegate = search;
#warning searchBar上面的背景跟tableview不一样,怎么去掉
    UIView *myView = [UIView new];
    myView.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    [myView addSubview:self.searchController.searchBar];
    self.tableView.tableHeaderView = myView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 计算文本高度
- (CGFloat)calTextHeight:(NSString *)str{
    CGRect size = [str boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return size.size.height;
}

#pragma mark - 添加功能
//添加新联系人
- (void)addNewContact:(UIBarButtonItem *)sender{
    //创建视图
    AddViewController *add = [[AddViewController alloc] init];
    //设置代理
    add.delegate = self;
    //设置导航控制器
    UINavigationController *addNav = [[UINavigationController alloc] initWithRootViewController:add];
    //模态视图
    [self.navigationController presentViewController:addNav animated:YES completion:nil];
}

#pragma mark - Table view data source
//返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _array.count;
}
//返回分组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //获取每个分组
    NSArray *arr = _dictionary[_array[section]];
    return arr.count;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    //获取
    Person *per = [Person new];
    NSArray *arr =  _dictionary[_array[indexPath.section]];
    [per setValuesForKeysWithDictionary:arr[indexPath.row]];
    //设置
    cell.per = per;
    
    return cell;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//设置快速索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _array;
}
//设置分组名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _array[section];
}

#pragma mark - tableview点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取点击的人
    NSArray *arr = _dictionary[_array[indexPath.section]];
    NSDictionary *dic = arr[indexPath.row];
    Person *per = [Person new];
    //赋值
    [per setValuesForKeysWithDictionary:dic];
    DetailsViewController *details = [[DetailsViewController alloc] init];
    //传值
    details.per = per;
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark - tableview编辑事件
//1.设置tableview可编辑
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //父类发送消息
    [super setEditing:editing animated:animated];
    //tableview设置状态
    [self.tableView setEditing:editing animated:animated];
    //title状态
    self.editButtonItem.title = editing ? @"完成" : @"编辑";
}

//2.指定那些行可以被编辑(默认所有行都可以被编辑)
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//3.设置编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//4.完成编辑
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
        // Delete the row from the data source
    //处理数据
    //获取分组
    NSString *key = _array[indexPath.section];
    NSMutableArray *arr = _dictionary[key];
    //判断分组人数
    if (arr.count == 1) {
        //删除整个分组
        //从dictionary中删除分组
        [_dictionary removeObjectForKey:key];
        //删除快速索引
        [_array removeObjectAtIndex:indexPath.section];
        //UI上处理
        //获取删除的分组
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
        //移除
        [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    }else{
        //删除联系人
        //从arr中移除联系人
        [arr removeObjectAtIndex:indexPath.row];
        //操作UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

#pragma mark - tableview移动操作

//2.设置可以移动的行
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

//3.移动完成
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    //获取分组
    NSMutableArray *arr = _dictionary[_array[fromIndexPath.section]];
    //获取删除的联系人
    NSDictionary *dic = arr[fromIndexPath.row];
    //从原位置删除数据
    [arr removeObjectAtIndex:fromIndexPath.row];
    //插入到目标位置
    [arr insertObject:dic atIndex:toIndexPath.row];
    
}


//检测跨行移动
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    //判断是否在同一个分组
    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        
        return proposedDestinationIndexPath;
    }
    //不再在同一个分区,返回源路径
    return sourceIndexPath;
}


#pragma mark - tableview添加完成
- (void)sendPerson:(Person *)per{
    //数据处理
    //per信息转换为字典
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:per.name,@"name",per.gender,@"gender",per.image,@"image",per.phoneNumber,@"phoneNumber", nil];
    //获取联系人姓名首字母,并转化为大写
    NSString *key = [[per.name substringToIndex:1] capitalizedString];
    //判断分组是否存在
    NSMutableArray *arr = _dictionary[key];
    if (arr == nil) {
        //如果分组不存在
        arr = [NSMutableArray arrayWithObject:dic];
        //添加分组
        [_dictionary setObject:arr forKey:key];
        //UI操作
        //添加索引
        [_array addObject:key];
        [_array sortUsingSelector:@selector(compare:)];
    }else{
        //如果存在,直接添加到末尾
        [arr addObject:dic];
    }
    //重新加载数据
    [self.tableView reloadData];
    
}

//获取某个元素在数组中的下标
- (NSUInteger)getObjectIndexFromArray:(NSArray *)array andObject:(NSObject *)object{
    //循环
    for (int i = 0; i < array.count; i++) {
        //判断
        if ([object isEqual:array[i]]) {
            return i;
        }
    }
    
    return -1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
