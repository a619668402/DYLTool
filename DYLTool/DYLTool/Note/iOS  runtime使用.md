###  iOS runtime 使用
------------------------------

1. 更改属性值

`
unsigned int count = 0;
Ivar *ivar = class_copyIvarList(_person.class, &count);
for (int i = 0; i < count; i ++) {
    Ivar tempIvar = ivar[i];
    const char *varChar = ivar_getName(tempIvar);
    NSString *varString = [NSString stringWithUTF8String:varChar];
    if ([varString isEqualToString:@"_name"]) {
        object_setIvar(_person, tempIvar, @"更改的属性值");
        break;
    }  
}
`

2. 动态添加属性

`
- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, @"name");
}

使用 NSObject 创建对象就会有一个name属性
NSObject *person = [NSObject new];
person.name = @"Test";

`

3. 动态添加方法
person类中没有coding方法, 通过runtime给person类添加一个coding的方法.
`
- (void)buttonClick:(UIButton *)sender {
    // 动态添加coding方法
    // (IMP)codingOC : codingOC的地址指针
    // "v@:" : v代表无返回值,如果是i则代表int;@代表id sel; : 代表 SEL _cmd;
    // "v@:@@" : 两个参数的没有返回值
    class_addMethod([_person class], @selector(coding), (IMP)codingOC, "v@:");
    // 调用coding方法响应事件
    if ([_person respondsToSelector:@selector(coding)]) {
        [_person performSelector:@selector(coding)];
        self.textLabel.text = @"添加成功";
        
    } else {
        self.textLabel.text = @"添加失败";
    }
    
}
void codingOC(id self, SEL _cmd) {
    NSLog(@"添加方法成功");
}
`
