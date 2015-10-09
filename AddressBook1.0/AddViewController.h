//
//  AddViewController.h
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@protocol AddNewPerson <NSObject>

- (void)sendPerson:(Person *)per;

@end

@interface AddViewController : UIViewController

//设置代理
@property (nonatomic,assign) id<AddNewPerson>delegate;

@end
