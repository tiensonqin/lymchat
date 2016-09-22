#import "StatusBarBackground.h"

@implementation StatusBarBackground
RCT_EXPORT_MODULE();
- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}


RCT_EXPORT_METHOD(setBackgroundColor:(CGFloat)red :(CGFloat)green :(CGFloat)blue :(CGFloat)alpha)
{

  UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

  UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
  view.backgroundColor = [UIColor colorWithRed: red
                                         green: green
                                          blue: blue
                                         alpha: alpha];
  view.tag=27;
  [rootViewController.view addSubview:view];
}

RCT_EXPORT_METHOD(removeBarView)
{
  UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
  UIView *viewToRemove = [rootViewController.view viewWithTag:27];
  [viewToRemove removeFromSuperview];
}

RCT_EXPORT_METHOD(removeBackgroundColor)
{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    rootViewController.view.backgroundColor = [UIColor whiteColor];
}

@end
