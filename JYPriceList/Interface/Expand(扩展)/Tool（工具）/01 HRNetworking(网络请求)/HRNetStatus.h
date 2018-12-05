
/*================================
||    @param name   netStatus    ||
||    @param author muyingbo     ||
||    @param date   2016-04-02   ||
=================================*/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HRNetStatusEnum) {
    HRNetStatusEnumNotNet = 0,
    HRNetStatusEnumCellular,
    HRNetStatusEnumWifi,
};

@interface HRNetStatus : NSObject

/**
 *  status
 */
@property (nonatomic, assign)HRNetStatusEnum status;

/**
 *  singleton
 *
 *  @return instancetype
 */
+ (instancetype)shareInstance;

@end
