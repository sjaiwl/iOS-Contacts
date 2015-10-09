//
//  SearchResultController.m
//  AddressBook1.0
//
//  Created by 王林 on 15/10/8.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "SearchResultController.h"

@interface SearchResultController ()

@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchResultsUpdating代理事件
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //实现搜索功能
}

#pragma mark - UISearchControllerDelegate代理事件
- (void)willPresentSearchController:(UISearchController *)searchController{
    //设置取消按钮
    [searchController.searchBar setShowsCancelButton:YES animated:YES];
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
