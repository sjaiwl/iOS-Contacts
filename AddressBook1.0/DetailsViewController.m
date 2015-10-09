//
//  DetailsViewController.m
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //创建视图
    [self creatView];
    //设置标题
    self.navigationItem.title = _per.name;
    self.navigationController.navigationBar.translucent = NO;
}

//创建视图
- (void)creatView{
    
    //头像
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(50, 20, 114, 114)];
    image.image = [UIImage imageNamed:_per.image];
    [self.view addSubview:image];
    //姓名
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(200, 20, 100, 30)];
    name.text = _per.name;
    [self.view addSubview:name];
    //性别
    UILabel *gender = [[UILabel alloc] initWithFrame:CGRectMake(200, 60, 100, 30)];
    gender.text = _per.gender;
    [self.view addSubview:gender];
    //电话
    UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 200, 30)];
    phone.text = _per.phoneNumber;
    [self.view addSubview:phone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
