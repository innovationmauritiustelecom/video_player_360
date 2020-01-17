#import <UIKit/UIKit.h>

@interface VideoPlayerViewController : UIViewController

@property (strong, nonatomic) NSURL *videoURL;
@property(nonatomic, assign) int radius;
@property(nonatomic, assign) int verticalFov;
@property(nonatomic, assign) int horizontalFov;
@property(nonatomic, assign) int rows;
@property(nonatomic, assign) int columns;

@end
