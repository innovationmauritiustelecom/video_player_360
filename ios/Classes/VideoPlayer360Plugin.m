#import "VideoPlayer360Plugin.h"
#import "HTY360PlayerVC.h"

@implementation VideoPlayer360Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"innov.lab/video_player_360"
                                     binaryMessenger:[registrar messenger]];
    VideoPlayer360Plugin* instance = [[VideoPlayer360Plugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
  if ([@"playvideo" isEqualToString:call.method]) {
            
      NSString *video_url = call.arguments[@"video_url"];
      
      if (video_url != nil) {
          NSURL *url = [[NSURL alloc] initWithString:video_url];
          
          if (url != nil) {
              NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"360_bundle" ofType:@"bundle"];
              NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
              
              HTY360PlayerVC *videoController = [[HTY360PlayerVC alloc] initWithNibName:@"HTY360PlayerVC"
                                                                                 bundle:bundle
                                                                                    url:url];
              
              [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:videoController
                                                                                         animated:YES
                                                                                       completion:nil];
          }
      }
      

  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
