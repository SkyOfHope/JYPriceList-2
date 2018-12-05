

#import "NSString+PinYin.h"

@implementation NSString (PinYin)

//1.0 汉字转拼音（无音调，带空格）
- (NSString *)pinYin {
    if ([self length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);
        return ms;
    }
    return self;
}

//1.1 汉字转拼音（有音调，带空格）
- (NSString *)pinYinWithTone {
    if ([self length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
        return ms;
    }
    return self;
}

@end
