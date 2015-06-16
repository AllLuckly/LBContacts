//
//  LBContacts_VC.h
//  LBContacts
//  欢迎探讨交流：http://allluckly.cf/
//  个人博客地址：http://allluckly.cf/
//  Copyright (c) 2015年 Bison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBContacts_VC : UIViewController


@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;

- (NSMutableArray *)getBook;

-(void)sendSmsMessageWithPhoneNumber:(NSString *)phoneNumber;

@end
