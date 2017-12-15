//
//  lua_recorder.hpp
//  Simpco-mobile
//
//  Created by Reyn on 2017/12/14.
//

#ifndef lua_recorder_hpp
#define lua_recorder_hpp

#include "scripting/lua-bindings/manual/CCLuaEngine.h"
#include "cocos2d.h"
#include "scripting/lua-bindings/manual/lua_module_register.h"


int register_all_audio_recorder(lua_State* tolua_S);


#endif /* lua_recorder_hpp */
