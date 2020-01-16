//
//  GVRPlayerController.h
//  Pods
//
//  Created by Stephan Gopaul on 16/01/2020.
//

#import <UIKit/UIKit.h>
#import <GVRKit/GVRKit.h>

@interface GVRPlayerController : UIViewController

@property (strong, nonatomic) NSURL *videoURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSURL*)url;

@end
