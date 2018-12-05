
#import "HRRequestManager.h"
#import "HRIndicatorWindow.h"
#import "HRNetStatus.h"

@interface HRRequestManager ()

@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *protocol;
@property (nonatomic, copy)NSString *host;
@property (nonatomic, copy)NSString *port;
@property (nonatomic, copy)NSString *path;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HRRequestManager

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _manager;
}

+ (instancetype)manager {
    static HRRequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL]init];
    });
    return instance;
}
+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    return [HRRequestManager manager];
}
- (instancetype)copyWithZone:(struct _NSZone *)zone{
    return [HRRequestManager manager];
}
- (instancetype)init {
    return [self initWithBaseURL:nil];
    
}

- (instancetype)initWithBaseURL:(NSString *)url {
    self = [super init];
    if (self) {
        if (!url) {
            _protocol = URLProtocol;
            _host = URLHost;
            _port = URLPort;
        }
    }
    return self;
}



-(void)GET_PATH:(NSString *)path para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([[HRNetStatus shareInstance] status] == HRNetStatusEnumNotNet) {
        NSLog(@"很抱歉没有网络");
        return;
    }

    HRIndicatorWindow *window =[[HRIndicatorWindow alloc] init];
//    [window showHud];
    
    NSString *url = SF(@"%@%@%@%@", _protocol, _host, _port, path);
    
    NSLog(@"\n[URL]:%@",url);
    
    [self.manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [result chLog];
        
        success(result);
        
        [window hiddenHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n[Request Failure]:\n[Fail Code]:%ld\n[Fail Message]:%@", error.code, error.userInfo);
        failure(error);
        
        [window hiddenHud];
    }];
}


- (void)GET:(NSString *)url para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if ([[HRNetStatus shareInstance] status] == HRNetStatusEnumNotNet) {
        NSLog(@"很抱歉没有网络");
        return;
    }
    
    HRIndicatorWindow *window =[[HRIndicatorWindow alloc] init];
//    [window showHud];
    
    [self.manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [result chLog];
        
        success(result);
        
        [window hiddenHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n[Request Failure]:\n[Failure Code]:%ld\n[Failure Message]:%@", error.code, error.userInfo);
        failure(error);
        
        [window hiddenHud];
    }];
}

- (void)POST_PATH:(NSString *)path para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    HRIndicatorWindow *window =[[HRIndicatorWindow alloc] init];
//    [window showHud];
    
    NSString *url = SF(@"%@%@%@%@", _protocol, _host, _port, path);
    
    NSLog(@"\n[URL]:%@", url);
    
    [self.manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [result chLog];
        
        
        
        success(result);
        
        
        [window hiddenHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n[Request Failure]:\n[Failure Code]:%ld\n[Failure Message]:%@", error.code, error.userInfo);
        failure(error);
        [window hiddenHud];
    }];
}

- (void)POST:(NSString *)url para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    HRIndicatorWindow *window =[[HRIndicatorWindow alloc] init];
//    [window showHud];
    
    NSString *urlStr = SF(@"%@%@%@", _protocol, _host, _port);
    NSLog(@"\n[URL]:%@", urlStr);
    
    [self.manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [result chLog];
        
        success(result);
        
        [window hiddenHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n[Request Failure]:\n[Failure Code]:%ld\n[Failure Message]:%@", error.code, error.userInfo);
        failure(error);
        [window hiddenHud];
    }];
}


- (void)POST_PATH:(NSString *)path WithToken:(NSString *)token para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    HRIndicatorWindow *window =[[HRIndicatorWindow alloc] init];
    //    [window showHud];
    
    NSString *url = SF(@"%@%@%@%@", _protocol, _host, _port, path);
    
    NSLog(@"\n[URL]:%@", url);
    
    [self.manager.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
    
    [self.manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [result chLog];
        
        success(result);
        
        
        [window hiddenHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n[Request Failure]:\n[Failure Code]:%ld\n[Failure Message]:%@", error.code, error.userInfo);
        failure(error);
        [window hiddenHud];
    }];
}


- (void)POST_PATH:(NSString *)path WithInit_session:(NSString *)init_session para:(id)para success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    HRIndicatorWindow *window =[[HRIndicatorWindow alloc] init];
    //    [window showHud];
    
    NSString *url = SF(@"%@%@%@%@", _protocol, _host, _port, path);
    
    NSLog(@"\n[URL]:%@", url);
    
    [self.manager.requestSerializer setValue:init_session forHTTPHeaderField:@"init_session"];
    
    [self.manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [result chLog];
        
        success(result);
        
        
        [window hiddenHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n[Request Failure]:\n[Failure Code]:%ld\n[Failure Message]:%@", error.code, error.userInfo);
        failure(error);
        [window hiddenHud];
    }];
}




@end
