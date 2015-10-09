//
//  ContactCell.h
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface ContactCell : UITableViewCell

@property (nonatomic,retain) Person *per;

@property (nonatomic,retain) UIImageView *image;
@property (nonatomic,retain) UIImageView *gender;
@property (nonatomic,retain) UILabel *name;
@property (nonatomic,retain) UILabel *phone;

@end
