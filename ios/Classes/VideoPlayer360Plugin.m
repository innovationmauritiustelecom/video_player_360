#import "VideoPlayer360Plugin.h"
#import "VideoPlayerViewController.h"

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
      int radius = [call.arguments[@"radius"] intValue];
      int verticalFov = [call.arguments[@"verticalFov"] intValue];
      int horizontalFov = [call.arguments[@"horizontalFov"] intValue];
      int rows = [call.arguments[@"rows"] intValue];
      int columns = [call.arguments[@"columns"] intValue];
      bool showPlaceholder = [call.arguments[@"showPlaceholder"] boolValue];
      
      if (video_url != nil) {
          NSURL *url = [[NSURL alloc] initWithString:video_url];
          
          if (url != nil) {
              NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"360_bundle" ofType:@"bundle"];
              NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
              
              UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"GVRBoard" bundle:bundle];
              VideoPlayerViewController *viewController = (VideoPlayerViewController*)[storyBoard instantiateInitialViewController];
              viewController.videoURL = url;
              viewController.radius = radius;
              viewController.verticalFov = verticalFov;
              viewController.horizontalFov = horizontalFov;
              viewController.rows = rows;
              viewController.columns = columns;
              viewController.modalPresentationStyle = UIModalPresentationFullScreen;
              viewController.showPlaceholder = showPlaceholder;
              
              [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController
                                                                                           animated:YES
                                                                                         completion:nil];
              
          }
      }
      

  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
