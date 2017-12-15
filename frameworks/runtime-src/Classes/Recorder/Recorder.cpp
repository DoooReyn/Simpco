//
//  Recorder.cpp
//  Simpco-mobile
//
//  Created by Reyn on 2017/12/14.
//

#include <stdio.h>
#include "Recorder.h"

int AudioRecorder::startRecord(lua_State *L)
{
    return 0;
}

int AudioRecorder::stopRecord(lua_State *L)
{
    return 0;
}

void AudioRecorder::copyLua(std::string str)
{
    CCLOG("%s", str.c_str());
}
