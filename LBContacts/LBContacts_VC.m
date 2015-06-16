//
//  LBContacts_VC.m
//  LBContacts
//
//  Created by fhkj on 15/6/15.
//  Copyright (c) 2015年 Bison. All rights reserved.
//

#import "LBContacts_VC.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#define     jekPrompt                       @"提示"
#define     jekAddressBookMessage            @"来‘’找我吧"           //发短信 中的内容
@interface LBContacts_VC ()

@property (nonatomic, copy) NSMutableArray *personArray;
@property (nonatomic, assign)ABAddressBookRef addressBookRef;
@property NSInteger sectionNumber;
@property NSInteger recordID;


@end

@implementation LBContacts_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    _personArray = [NSMutableArray array];
        
    [self getBook];
}
#pragma mark - 获取手机中的通讯录以及解析联系人
-(NSMutableArray *)getBook
{
    
    if (_personArray == nil) {
        _personArray = [NSMutableArray array];
    }
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        
        
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    CFRelease(addressBooks);
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        LBContacts_VC *addressBook = [[LBContacts_VC alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            if (valuesRef)
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [_personArray addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
        
            }
    CFRelease(allPeople);
    return _personArray;
}
#pragma mark - 短信
-(void)sendSmsMessageWithPhoneNumber:(NSString *)phoneNumber
{
    if([MFMessageComposeViewController canSendText])
    {
        [self displaySMSComposerSheetPhoneNumber:phoneNumber];
    }
    else
    {
        UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:jekPrompt message:@"该设备不支持发短信" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [msgbox show];
    }
}
-(void)displaySMSComposerSheetPhoneNumber:(NSString *)phoneNumber
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = (id<MFMessageComposeViewControllerDelegate>)self;
    
    picker.recipients = [NSArray arrayWithObject:phoneNumber];
    
    picker.body=[NSString stringWithFormat:@"%@",jekAddressBookMessage];
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Result: SMS sending canceled");
            break;
        case MessageComposeResultSent:
            NSLog(@"Result: SMS sent");
            break;
        case MessageComposeResultFailed:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:jekPrompt message:@"短信发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            
            [msgbox show];
            
        }
            break;
        default:
            NSLog(@"Result: SMS not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
