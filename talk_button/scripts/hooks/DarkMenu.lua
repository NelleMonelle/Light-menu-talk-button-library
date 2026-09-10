---@class DarkMenu
local DarkMenu, super = HookSystem.hookScript(DarkMenu)

function DarkMenu:getButtonSpacing()
    if #self.buttons <= 4 then
        return 105
    else
        return 105 - (#self.buttons * #self.buttons)
    end
end

function DarkMenu:addButtons()
    super.addButtons(self)

    -- only add if not alone (if the config is false)
    if Kristal.getLibConfig("talk_button", "have_talk_when_alone") or #Game.world.followers > 0 then
        -- TALK
        self:addButton({
            ["state"]          = "TALK",
            ["sprite"]         = Assets.getTexture("ui/menu/btn/talk"),
            ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/talk_h"),
            ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/talk"),
            ["callback"]       = function()
                Input.clear("confirm")
                Game.world:closeMenu()

                self.ui_select:stop()
                self.ui_select:play()

                Game.world:startCutscene("_talk")
            end
        }, Kristal.getLibConfig("talk_button", "talk_button_position"))
    end
end

return DarkMenu