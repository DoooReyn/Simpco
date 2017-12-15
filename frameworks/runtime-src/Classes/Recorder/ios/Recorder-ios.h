//
//  Recorder-ios.h
//  Simpco
//
//  Created by Reyn on 2017/12/13.
//

#ifndef Recorder_ios_h
#define Recorder_ios_h

#import <Foundation/Foundation.h>

@interface Recorder : NSObject

//开始录音
- (void)startRecord;

//停止录音
- (void)stopRecord;

@end

#endif /* Recorder_ios_h */
