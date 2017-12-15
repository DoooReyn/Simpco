------------------------------------------------------------------------------------------
---- Name   : ViewConst
---- Desc   : 视图常量
---- Date   : 2017/12/10
---- Author : Reyn - jl88744653@gmail.com
------------------------------------------------------------------------------------------

----------------------------------------------------
-- @param swallow : 吞噬触摸
-- @param keep    : 是否常驻
--

local SceneZOrder = {
    Map     = -1,
    Object  = 10,
    UI      = 20,
    Msg     = 30,
    Guide   = 40,
}

local UIArgs = {
    LoginView               = { swallow = false,     zorder = 1,     keep = false },
    CreateRoleView          = { swallow = true,     zorder = 1,     keep = false },
    MainScreenView          = { swallow = true,     zorder = 1,     keep = true  },
    MainMenuView            = { swallow = true,     zorder = 1,     keep = true  },
    SystemConfiguraionView  = { swallow = true,     zorder = 1,     keep = false },
}

return {
    SceneZOrder = SceneZOrder,
    UIArgs      = UIArgs,
}