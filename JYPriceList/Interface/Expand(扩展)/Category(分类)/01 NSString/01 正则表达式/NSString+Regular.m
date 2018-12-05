

#import "NSString+Regular.h"

@implementation NSString (Regular)

//1.0 正则验证(通用) regex 正则表达式 返回值：验证结果
- (BOOL)regular:(NSString *)regex {
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.1 验证电话号码
- (BOOL)checkTelephoneNumber {
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.2 验证身份证
- (BOOL)checkIDCard {
    NSString *regex = @"\\d{15}(\\d\\d[0-9xX])?";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.3 验证邮箱
- (BOOL)checkEmail {
    NSString *regex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.4 验证纯数字
- (BOOL)checkJustNumber {
    NSString *regex = @"^[0-9]+$";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.5 验证URL
- (BOOL)checkURL {
    NSString *regex = @"^http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.6 验证只是汉字
- (BOOL)checkJustChinese {
    NSString *regex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.7 验证只是字母
- (BOOL)checkJustLetter {
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.8 验证只是小写字母
- (BOOL)checkJustLowercase {
    NSString *regex = @"^[a-z]+$";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.9 验证只是大写字母
- (BOOL)checkCapitalLetter {
    NSString *regex = @"^[A-Z]+$";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}

//1.10 验证包含特殊字符
- (BOOL)checkContainSpecialCharacter {
    NSString *regex = @"[~`!@#$%^&*':;\"\?=/<>,\\.\\{\\}\\[\\]\\(\\)]+";
    NSPredicate *predicateRe = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicateRe evaluateWithObject:self];
}



@end
