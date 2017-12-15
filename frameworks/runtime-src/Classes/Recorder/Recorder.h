//
//  Recorder.h
//  Simpco
//
//  Created by Reyn on 2017/12/13.
//

#ifndef Recorder_h
#define Recorder_h

#include <iostream>
#include "cocos2d.h"
USING_NS_CC;


//#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
//#include "Recorder-ios.h"
//#endif

class AudioRecorder
{
public:
    static int startRecord(lua_State *L);
    static int stopRecord(lua_State *L);
    void copyLua(std::string str);
};


#endif /* Recorder_h */
