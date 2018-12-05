/*================================
||    @param name   NetRequest   ||
||    @param author muyingbo     ||
||    @param date   2016-03-28   ||
=================================*/

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HRRequestManager : NSObject

/**
 *  init (singleton)
 *
 *  @return instancetype
 */
+ (instancetype)manager;


/**
 *  GET request, just path
 *
 *  @param path
 *  @param para
 *  @param success
 *  @param failure
 */
- (void)GET_PATH:(NSString *)path para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  GET request, url
 *
 *  @param url
 *  @param para
 *  @param success
 *  @param failure
 */
- (void)GET:(NSString *)url para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 *  POST request, just path
 *
 *  @param path
 *  @param para
 *  @param success
 *  @param failure
 */
- (void)POST_PATH:(NSString *)path para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  POST request, url
 *
 *  @param url
 *  @param para
 *  @param success
 *  @param failure
 */
- (void)POST:(NSString *)url para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

- (void)POST_PATH:(NSString *)path WithToken:(NSString *)token para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


- (void)POST_PATH:(NSString *)path WithInit_session:(NSString *)init_session para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
