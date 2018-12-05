
#import "HRIndicatorWindow.h"
#import "MBProgressHUD.h"
#import "Masonry.h"

@interface HRIndicatorWindow ()

/**
 *  indicator
 */
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation HRIndicatorWindow


#pragma mark - ---------- Lazy loading ----------
- (MBProgressHUD *)hud {
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc] initWithWindow:self];
        [_hud show:YES];
    }
    return _hud;
}

#pragma mark - ---------- Lifecycle ----------
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self configUI];
        
    }
    return self;
}



#pragma mark - ---------- Public Methods ----------

#pragma mark override super
- (void)layoutSubviews {
    
    [self layoutSelf];
    [self layoutHud];
}

/**
 *  show hub
 */
- (void)showHud {
    [self makeKeyAndVisible];
}

/**
 *  hidden hub
 */
- (void)hiddenHud {
    self.hidden = YES;
}



#pragma mark - ---------- Private Methods ----------

- (void)configUI {
    [self configSelf];
    [self addSubview:self.hud];
}

- (void)configSelf {
    self.backgroundColor = [UIColor clearColor];
    self.windowLevel = 2999.0f;
    self.rootViewController = [[UIViewController alloc] init];
}


- (void)layoutSelf {
    self.frame = Screen_Bounds;
}

- (void)layoutHud {
    weakSelf(weakSelf);
    [self.hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}






@end
