------------------------------------
-- Name : RedStem 小红点节点
-- Author : Reyn
-- Date : 2017-12-19
--
local RedStem = class('RedStem')

-- 小红点状态值定义
local RedTipState = {
    Hide = false,
    Show = true,
}
RedStem.RedTipState = RedTipState

--小红点开关值定义
local RedTipSwitch = {
    Close = false,
    Open  = true,
}
RedStem.RedTipSwitch = RedTipSwitch

local strfmt = string.format

function RedStem:ctor(stemID)
    self.parent   = nil                --父亲节点(视情况可以扩展成多对多的关系结构，但不建议这么做，因为这样树结构会特别复杂)
    self.children = {}                 --孩子节点
    self.stemID   = stemID             --节点ID
    self.dirty    = false              --脏标记
    self.number   = 0                  --消息数量
    self.state    = RedTipState.Hide   --默认隐藏
    self.switch   = RedTipSwitch.Close --默认关闭
end

function RedStem:getID()
    return self.stemID
end

function RedStem:isDirty()
    return self.dirty
end

function RedStem:isEnable()
    return self.enable
end

function RedStem:enable(isenable)
    if self.enable == isenable then
        return 
    end
    self.enable = isenable
end

function RedStem:show()
    if self.self.state then
        return
    end
    self.state = RedTipState.Show  
    self.dirty = true
end

function RedStem:hide()
    if not self.state then
        return
    end
    self.state = RedTipState.Hide 
    self.dirty = true
end

function RedStem:getState()
    return self.state
end

function RedStem:setNum(num)
    if self.number == num then
        return
    end
    self.number = num 
    self.dirty = true
end

function RedStem:getNum()
    return self.number
end

function RedStem:setParent(stem)
    if self.parent then 
        return
    end
    self.parent = stemID
end

function RedStem:addChild(stem)
    if self.children[stem:getID()] then
        return
    end
    self.children[stem:getID()] = stem
end

function RedStem:getParent()
    return self.parent
end

function RedStem:getChildren()
    return self.children
end

function RedStem:update()
    if not self.isDirty then
        return
    end
    self:sendNotice()
    self.isDirty = false
end

function RedStem:findChild(stemID)
    local stem = self.children[stemID]
    if stem then
        return stem
    end 
    for _, child in pairs(self.children) do
        local ok, stem = child:findChild(stemID)
        if ok then
            return stem
        end
    end
    return nil
end

function RedStem:sendNotice()

end

function RedStem:dumpStemInfo()
    print('\n-----------------------------------')
    print('Stem :')
    print('  ID       - ' .. self:getID())
    print('  State    - ' .. tostring(self.state))
    print('  Number   - ' .. self.number)
    print('  Parent   - ' .. (self.parent and self.parent:getId() or "none"))
    print('  Children - ')
    for i,v in ipairs(self.children) do
        print(strfmt("    [%d] ID -> %d", i, v:getID()))
    end
end

return RedStem
