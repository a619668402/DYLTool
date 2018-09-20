//
//  CompanyInfo.h
//  DYLTool
//
//  Created by sky on 2018/9/5.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB.h>

@interface CompanyInfo : NSObject <WCTTableCoding>

@property (assign) int companyId;

@property (copy) NSString *companyName;

@property (copy) NSString *companyAddress;

WCDB_PROPERTY(companyId)
WCDB_PROPERTY(companyName)
WCDB_PROPERTY(companyAddress)

@end
