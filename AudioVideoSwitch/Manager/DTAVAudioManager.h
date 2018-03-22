//
//  WOAVAudioManager.h
//  AudioVideoSwitch
//
//  Created by dubhe on 2018/3/22.
//  Copyright © 2018年 Dubhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTPlayer.h"

typedef NS_ENUM(NSUInteger, DTAudioPlayerStateType) {
    DTAudioPlayerStateTypeNone,
    DTAudioPlayerStateTypeLoading,
    DTAudioPlayerStateTypePlaying,
    DTAudioPlayerStateTypePause,
    DTAudioPlayerStateTypeCompletion,
};

typedef NS_ENUM(NSUInteger, DTVideoPlayerStateType) {
    DTVideoPlayerStateTypeNone,
    DTVideoPlayerStateTypeLoading,
    DTVideoPlayerStateTypePlaying,
    DTVideoPlayerStateTypePause,
    DTVideoPlayerStateTypeCompletion,
};

typedef NS_ENUM(NSUInteger, DTVideoPlayBackType) {
    DTVideoPlayBackTypeMute,
    DTVideoPlayBackTypeFullScreen,
    DTVideoPlayBackTypeSuspension,
};

@interface DTAVAudioManager : NSObject

+ (instancetype)shareManager;
- (void)audioPlay;
- (void)videoPlay;
- (void)audioPause;
- (void)videoPause;
- (void)audioPlayCompletion;
- (void)videoPlayCompletion;

@property (nonatomic, copy)   NSURL                     *audioAssetURL;
@property (nonatomic, copy)   NSURL                     *videoAssetURL;
@property (nonatomic, strong) DTPlayer                  *audioPlayer;
@property (nonatomic, strong) DTPlayer                  *videoPlayer;
@property (nonatomic, assign) DTAudioPlayerStateType    audioPlayerState;
@property (nonatomic, assign) DTVideoPlayerStateType    videoPlayerState;
@property (nonatomic, assign) DTVideoPlayBackType       videoPlayBackType;
@end
