#import <UIKit/UIKit.h>
#import <GVRKit/GVRKit.h>

#import "VideoPlayerViewController.h"

@interface VideoPlayerViewController ()<GVRRendererViewControllerDelegate>
@property (nonatomic) IBOutlet GVRRendererView *videoView;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (weak, nonatomic) IBOutlet UIView *tiltView;
@property (nonatomic) AVPlayer *player;
@property (nonatomic) NSBundle *bundle;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

    // NSURL *videoURL = [NSURL URLWithString:@"http://196.192.110.79:1935/test/videoplay/playlist.m3u8"];
    [_loader startAnimating];
      
    _player = [AVPlayer playerWithURL:_videoURL];
    _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[_player currentItem]];

    GVRRendererViewController *viewController = self.childViewControllers[0];
    GVRSceneRenderer *sceneRenderer = (GVRSceneRenderer *)viewController.rendererView.renderer;
    GVRVideoRenderer *videoRenderer = [sceneRenderer.renderList objectAtIndex:0];
    videoRenderer.player = _player;
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"360_bundle" ofType:@"bundle"];
    _bundle = [NSBundle bundleWithPath:bundlePath];
    
    [self hideGVRButtons];
    [self addObservers];
    [self hideTiltView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self updateVideoPlayback];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeObservers];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [super prepareForSegue:segue sender:sender];
  if ([segue.destinationViewController isKindOfClass:[GVRRendererViewController class]]) {
    GVRRendererViewController *viewController = segue.destinationViewController;
    viewController.delegate = self;
  }
}

#pragma mark - Actions

- (IBAction)didTapPlayPause:(id)sender {
    [self updateVideoPlayback];
}

- (IBAction)didTapBack:(id)sender {
    //[self.navigationController popViewControllerAnimated:TRUE];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}


//- (void)updateProgressBar {
//  UIProgressView *progressView = (UIProgressView *)_progressBar.customView;
//  double duration = CMTimeGetSeconds(_player.currentItem.duration);
//  double time = CMTimeGetSeconds(_player.currentTime);
//  progressView.progress = (CGFloat)(time / duration);
//}

#pragma mark - AVPlayer

- (void)playerItemDidReachEnd:(NSNotification *)notification {
  AVPlayerItem *player = [notification object];
  [player seekToTime:kCMTimeZero];
}

#pragma mark - GVRRendererViewControllerDelegate

- (void)didTapTriggerButton {
  [self updateVideoPlayback];
}

- (GVRRenderer *)rendererForDisplayMode:(GVRDisplayMode)displayMode {
    GVRVideoRenderer *videoRenderer = [[GVRVideoRenderer alloc] init];
    videoRenderer.player = _player;
    
//    [videoRenderer setSphericalMeshOfRadius:50
//                                  latitudes:50
//                                 longitudes:50
//                                verticalFov:180
//                              horizontalFov:360
//                                   meshType:kGVRMeshTypeMonoscopic]; // kGVRMeshTypeStereoTopBottom
    
    [videoRenderer setSphericalMeshOfRadius:_radius
                                  latitudes:_rows
                                 longitudes:_columns
                                verticalFov:_verticalFov
                              horizontalFov:_horizontalFov
                                   meshType:kGVRMeshTypeMonoscopic]; // kGVRMeshTypeStereoTopBottom


    GVRSceneRenderer *sceneRenderer = [[GVRSceneRenderer alloc] init];
    [sceneRenderer.renderList addRenderObject:videoRenderer];
    sceneRenderer.hidesReticle = YES;
    
    
  /*if (displayMode == kGVRDisplayModeEmbedded) {
    // Hide the reticle in embedded mode.
    sceneRenderer.hidesReticle = YES;
  } else {
    // In fullscreen mode, add the toolbar to the GL scene.
    GVRUIViewRenderer *viewRenderer = [[GVRUIViewRenderer alloc] initWithView:_toolbar];

    // Position the playback controls half a meter in front (z = -0.5).
    GLKMatrix4 position = GLKMatrix4MakeTranslation(-0.0, -0.3, -0.5);
    // Rotate along x axis so that it looks oriented towards us.
    position = GLKMatrix4RotateX(position, GLKMathDegreesToRadians(-20));
    viewRenderer.position = position;

    [sceneRenderer.renderList addRenderObject:viewRenderer];
  }*/

  return sceneRenderer;
}

#pragma mark - Private

- (void)updateVideoPlayback {
    
    if (_player.rate == 1.0) {
        [_player pause];
        //_toolbar.items = @[ _playButton, _progressBar ];
        
        if (_bundle != nil) {
            [_playPauseButton setImage: [UIImage imageNamed:@"play" inBundle:_bundle compatibleWithTraitCollection:nil]
                              forState:UIControlStateNormal];
        }
        
    } else {
        [_player play];
        //_toolbar.items = @[ _pauseButton, _progressBar ];

        if (_bundle != nil) {
            [_playPauseButton setImage: [UIImage imageNamed:@"pause" inBundle:_bundle compatibleWithTraitCollection:nil]
            forState:UIControlStateNormal];
        }
    }
}

- (void)hideGVRButtons {
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        GVRRendererViewController *viewController = self.childViewControllers[0];
        self.videoView = (GVRRendererView *)viewController.view;
        self.videoView.overlayView.hidesBackButton = true;
        self.videoView.overlayView.hidesCardboardButton = true;
        self.videoView.overlayView.hidesFullscreenButton = true;
        self.videoView.overlayView.hidesSettingsButton = true;
    });
}

- (void)addObservers {
    [_player.currentItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [_player.currentItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    [_player.currentItem addObserver:self forKeyPath:@"playbackBufferFull" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers {
    [_player.currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty" context:nil];
    [_player.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp" context:nil];
    [_player.currentItem removeObserver:self forKeyPath:@"playbackBufferFull" context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isKindOfClass:[AVPlayerItem class]]) {
        if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
            [_loader setHidden:FALSE];
            //NSLog(@"playbackBufferEmpty");
            
        } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
            [_loader setHidden:TRUE];
            //NSLog(@"playbackLikelyToKeepUp");

        } else if ([keyPath isEqualToString:@"playbackBufferFull"]) {
            [_loader setHidden:TRUE];
            //NSLog(@"playbackBufferFull");
            
        }
    }
}

- (void)hideTiltView {
    if (!_showPlaceholder) {
        [self.tiltView setHidden:TRUE];
    } else {
        double delayInSeconds = 2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView transitionWithView:self.tiltView
                              duration:delayInSeconds
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                [self.tiltView setHidden:TRUE];
            } completion:NULL];
        });
    }
}

@end

