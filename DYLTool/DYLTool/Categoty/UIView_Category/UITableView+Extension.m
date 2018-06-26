//
//  UITableView+Extension.m
//  DYLTool
//
//  Created by sky on 2018/6/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

- (void)yl_registerCell:(Class)cls {
    [self yl_registerCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}

- (void)yl_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier {
    [self registerClass:cls forCellReuseIdentifier:reuseIdentifier];
}


- (void)yl_registerNibCell:(Class)cls {
    [self yl_registerNibCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}

- (void)yl_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIndetifier {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forCellReuseIdentifier:reuseIndetifier];
}
@end
