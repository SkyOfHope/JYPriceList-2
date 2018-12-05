
#import "HRNetStatus.h"

@implementation HRNetStatus

+ (instancetype)shareInstance {
    static HRNetStatus * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL]init];
    });
    return instance;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    return [HRNetStatus shareInstance];
}
- (instancetype)copyWithZone:(struct _NSZone *)zone{
    return [HRNetStatus shareInstance];
}
@end
