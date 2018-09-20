//
//  CompanyInfo.m
//  DYLTool
//
//  Created by sky on 2018/9/5.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "CompanyInfo.h"

@implementation CompanyInfo

WCDB_IMPLEMENTATION(CompanyInfo)
WCDB_SYNTHESIZE(CompanyInfo, companyId)
WCDB_SYNTHESIZE(CompanyInfo, companyName)
WCDB_SYNTHESIZE(CompanyInfo, companyAddress)

//WCDB_PRIMARY(CompanyInfo, companyId)
WCDB_PRIMARY_AUTO_INCREMENT(CompanyInfo, companyId)
//WCDB_INDEX(CompanyInfo, "_index", companyId)

- (NSString *)description {
    return KStringWithFormat(@"companyId = %d, companyName = %@, companyAddress = %@", self.companyId, self.companyName, self.companyAddress);
}

@end
