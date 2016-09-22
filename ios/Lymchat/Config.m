#import "Config.h"

@implementation Config
RCT_EXPORT_MODULE();

- (NSDictionary *)constantsToExport
{
    return @{
        @"app_key": APP_KEY,
        @"app_secret": APP_SECRET,
        @"google_signin_client_id": GOOGLE_SIGN_CLIENT_ID,
        @"wechat_id": WECHAT_ID,
        @"wechat_secret": WECHAT_SECRET,
        @"wechat_state": WECHAT_STATE
        };
}
@end
