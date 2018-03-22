//
//  ViewController.m
//  AudioVideoSwitch
//
//  Created by dubhe on 2018/3/22.
//  Copyright © 2018年 Dubhe. All rights reserved.
//

#import "ViewController.h"
#import "DTPlayer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (nonatomic, strong) DTPlayer *audioPlayer;
@property (nonatomic, strong) DTPlayer *videoPlayer;
@property (weak, nonatomic) IBOutlet UIView *videoPlayerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *audioAssetURL = [[NSBundle mainBundle] URLForResource:@"music" withExtension:@"mp3"];
    DTPlayer *audioPlayer = [[DTPlayer alloc] initWithAssetURL:audioAssetURL];
    self.audioPlayer = audioPlayer;
    NSURL *videoAssetURL = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"mov"];
    DTPlayer *videoPlayer = [[DTPlayer alloc] initWithAssetURL:videoAssetURL];
    self.videoPlayer = videoPlayer;
    
    CGRect bounds = self.videoPlayerView.bounds;
    videoPlayer.playerLayer.frame = bounds;
    videoPlayer.playerLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.videoPlayerView.layer addSublayer:videoPlayer.playerLayer];
}

- (IBAction)playButtonDidTap:(id)sender {
    [self audioSessionSwitchToMyApp];
    [self.audioPlayer play];
}

- (IBAction)pauseButtonDidTap:(id)sender {
    [self.audioPlayer pause];
    while (self.audioPlayer.player.rate == 0) {
        [self audioSessionSwitchToOtherApp];
        break;
    }
}
- (IBAction)videoPlay:(id)sender {
    [self videoSessionSwitchToMyApp];
    [self.videoPlayer.player setMuted:YES];
    [self.videoPlayer play];
}

- (IBAction)videoPause:(id)sender {
    [self.videoPlayer pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)videoSessionSwitchToMyApp {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"Video Category Error: %@", error.localizedDescription);
    }
    if (![session setActive:YES error:&error]) {
        NSLog(@"Video Active Error %@", error.localizedDescription);
    }
}

- (void)videoSessionSwitchToOtherApp {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"Video Category Error: %@", error.localizedDescription);
    }
    if (![session setActive:NO error:&error]) {
        NSLog(@"Video Active Error %@", error.localizedDescription);
    }
}

- (void)audioSessionSwitchToMyApp {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"audio Category Error: %@", error.localizedDescription);
    }
    if (![session setActive:YES error:&error]) {
        NSLog(@"audio Active Error %@", error.localizedDescription);
    }
}

- (void)audioSessionSwitchToOtherApp {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"audio Category Error: %@", error.localizedDescription);
    }
    if (![session setActive:NO error:&error]) {
        NSLog(@"aduio Active Error %@", error.localizedDescription);
    }
}

- (IBAction)fullScreen:(id)sender {
    [self.videoPlayer.player setMuted:NO];
}

- (IBAction)smallScreen:(id)sender {
    [self.videoPlayer.player setMuted:YES];
}


@end
