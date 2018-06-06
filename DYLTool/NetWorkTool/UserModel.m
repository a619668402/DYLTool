//
//  UserModel.m
//  NetWorkTool
//
//  Created by sky on 2018/5/15.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

@end

@implementation UserInfoModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.ua_nickname = [aDecoder decodeObjectForKey:@"ua_nickname"];
        self.ua_avatar = [aDecoder decodeObjectForKey:@"ua_avatar"];
        self.ua_sex = [aDecoder decodeObjectForKey:@"ua_sex"];
        self.ua_bithday = [aDecoder decodeObjectForKey:@"ua_bithday"];
        self.ua_mobile = [aDecoder decodeObjectForKey:@"ua_mobile"];
        self.ua_company = [aDecoder decodeObjectForKey:@"ua_company"];
        self.ua_company_address = [aDecoder decodeObjectForKey:@"ua_company_address"];
        self.ua_business_card = [aDecoder decodeObjectForKey:@"ua_business_card"];
        self.ua_province_id = [aDecoder decodeObjectForKey:@"ua_province_id"];
        self.ua_province_name = [aDecoder decodeObjectForKey:@"ua_province_name"];
        self.ua_city_id = [aDecoder decodeObjectForKey:@"ua_city_id"];
        self.ua_city_name = [aDecoder decodeObjectForKey:@"ua_city_name"];
        self.ua_region_id = [aDecoder decodeObjectForKey:@"ua_region_id"];
        self.ua_region_name = [aDecoder decodeObjectForKey:@"ua_region_name"];
        self.ua_verify_status = [aDecoder decodeObjectForKey:@"ua_verify_status"];
        self.ua_score = [aDecoder decodeObjectForKey:@"ua_score"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.uh_user_name = [aDecoder decodeObjectForKey:@"uh_user_name"];
        self.uh_password = [aDecoder decodeObjectForKey:@"uh_password"];
        self.uh_nick_name = [aDecoder decodeObjectForKey:@"uh_nick_name"];
        self.uh_friends = [aDecoder decodeObjectForKey:@"uh_friends"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.ua_nickname forKey:@"ua_nickname"];
    [aCoder encodeObject:self.ua_avatar forKey:@"ua_avatar"];
    [aCoder encodeObject:self.ua_sex forKey:@"ua_sex"];
    [aCoder encodeObject:self.ua_bithday forKey:@"ua_bithday"];
    [aCoder encodeObject:self.ua_mobile forKey:@"ua_mobile"];
    [aCoder encodeObject:self.ua_company forKey:@"ua_company"];
    [aCoder encodeObject:self.ua_company_address forKey:@"ua_company_address"];
    [aCoder encodeObject:self.ua_business_card forKey:@"ua_business_card"];
    [aCoder encodeObject:self.ua_province_id forKey:@"ua_province_id"];
    [aCoder encodeObject:self.ua_province_name forKey:@"ua_province_name"];
    [aCoder encodeObject:self.ua_city_id forKey:@"ua_city_id"];
    [aCoder encodeObject:self.ua_region_id forKey:@"ua_region_id"];
    [aCoder encodeObject:self.ua_city_name forKey:@"ua_city_name"];
    [aCoder encodeObject:self.ua_region_name forKey:@"ua_region_name"];
    [aCoder encodeObject:self.ua_verify_status forKey:@"ua_verify_status"];
    [aCoder encodeObject:self.ua_score forKey:@"ua_score"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.uh_user_name forKey:@"uh_user_name"];
    [aCoder encodeObject:self.uh_password forKey:@"uh_password"];
    [aCoder encodeObject:self.uh_nick_name forKey:@"uh_nick_name"];
    [aCoder encodeObject:self.uh_friends forKey:@"uh_friends"];
}

@end

@implementation Friends

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.uh_user_name = [aDecoder decodeObjectForKey:@"uh_user_name"];
        self.un_nick_name = [aDecoder decodeObjectForKey:@"un_nick_name"];
        self.cus_id = [aDecoder decodeObjectForKey:@"cus_id"];
        self.uc_nickname = [aDecoder decodeObjectForKey:@"uc_nickname"];
        self.uc_avatar = [aDecoder decodeObjectForKey:@"uc_avatar"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uh_user_name forKey:@"uh_user_name"];
    [aCoder encodeObject:self.un_nick_name forKey:@"un_nick_name"];
    [aCoder encodeObject:self.cus_id forKey:@"cus_id"];
    [aCoder encodeObject:self.uc_nickname forKey:@"uc_nickname"];
    [aCoder encodeObject:self.uc_avatar forKey:@"uc_avatar"];
}

@end
