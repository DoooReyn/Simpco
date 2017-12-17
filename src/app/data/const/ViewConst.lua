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
    Action  = 50,
}

local UIArgs = {
    LoginView               = { swallow = true, keep = false },
    CreateRoleView          = { swallow = true, keep = false },
    MainScreenView          = { swallow = true, keep = true  },
    MainMenuView            = { swallow = true, keep = true  },
    SystemConfiguraionView  = { swallow = true, keep = false },
}

return {
    SceneZOrder = SceneZOrder,
    UIArgs      = UIArgs,
}