//
//  ContactCell.m
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建视图
        [self creatSubViews];
    }
    
    return self;
}

- (void)creatSubViews{
    //头像
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    _image.layer.masksToBounds = YES;
    _image.layer.cornerRadius = 30;
    [self.contentView addSubview:_image];
    
    //姓名
    _name = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 100, 30)];
    _name.textColor = [UIColor blackColor];
    [self.contentView addSubview:_name];
    
    //性别
    _gender = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 30, 30)];
    [self.contentView addSubview:_gender];
    
    //电话
    _phone = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 30)];
    _phone.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_phone];
}

- (void)setPer:(Person *)per{
    _image.image = [UIImage imageNamed:per.image];
    _name.text = per.name;
    _phone.text = per.phoneNumber;
    if ([per.gender isEqualToString:@"男"]) {
        _gender.image = [UIImage imageNamed:@"male.png"];
    }else{
        _gender.image = [UIImage imageNamed:@"female.png"];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
