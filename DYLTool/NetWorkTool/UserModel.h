//
//  UserModel.h
//  NetWorkTool
//
//  Created by sky on 2018/5/15.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseResponse.h"

@class UserInfoModel;
@class Friends;

@interface UserModel : BaseResponse

@property (nonatomic,strong) UserInfoModel *data;

@end

@interface UserInfoModel : NSObject<NSCoding>

@property(nonatomic, copy) NSString *ua_nickname;

@property(nonatomic, copy) NSString *ua_avatar;

@property(nonatomic, copy) NSString *ua_sex;

@property(nonatomic, copy) NSString *ua_bithday;

@property(nonatomic, copy) NSString *ua_mobile;

@property(nonatomic, copy) NSString *ua_company;

@property(nonatomic, copy) NSString *ua_company_address;

@property(nonatomic, copy) NSString *ua_business_card;

@property(nonatomic, copy) NSString *ua_province_id;

@property(nonatomic, copy) NSString *ua_province_name;

@property(nonatomic, copy) NSString *ua_city_id;

@property(nonatomic, copy) NSString *ua_city_name;

@property(nonatomic, copy) NSString *ua_region_id;

@property(nonatomic, copy) NSString *ua_region_name;

@property(nonatomic, copy) NSString *ua_verify_status;

@property(nonatomic, copy) NSString *ua_score;

@property(nonatomic, copy) NSString *token;

@property(nonatomic, copy) NSString *uh_user_name;

@property(nonatomic, copy) NSString *uh_nick_name;

@property(nonatomic, copy) NSString *uh_password;

@property(nonatomic, copy) NSArray *uh_friends;

@end

@interface Friends : NSObject<NSCoding>

@property(nonatomic, copy) NSString *uh_user_name;

@property(nonatomic, copy) NSString *un_nick_name;

@property(nonatomic, copy) NSString *cus_id;

@property(nonatomic, copy) NSString *uc_nickname;

@property(nonatomic, copy) NSString *uc_avatar;

@end
