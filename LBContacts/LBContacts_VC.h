//
//  LBContacts_VC.h
//  LBContacts
//
//  Created by fhkj on 15/6/15.
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
