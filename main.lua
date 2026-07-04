SMODS.Language {
    key = "bad_translate",
    label = "Google Translated"
}

BTR_config = SMODS.current_mod.config

local function config()
    local nodes = {}
    nodes[#nodes+1] = create_toggle{
        label = localize("k_bad_alt_shop_sign"),
        active_colour = HEX("c74040"),
        ref_table = BTR_config,
        ref_value = "alt_shop_sign"
    }
    nodes[#nodes+1] = create_toggle{
        label = localize("k_bad_alt_main_menu"),
        active_colour = HEX("c74040"),
        ref_table = BTR_config,
        ref_value = "alt_main_menu"
    }
    --[[
    nodes[#nodes+1] = create_toggle{
        label = localize("k_bad_gameplay_changes"),
        active_colour = HEX("c74040"),
        ref_table = BTR_config,
        ref_value = "gameplay_changes"
    }]]
    return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = nodes,
	}
end

SMODS.Atlas {
    key = "T_card",
    path = "T_card.png",
    px = 71,
    py = 95,
}

SMODS.current_mod.config_tab = config

if BTR_config.alt_shop_sign then
    SMODS.Atlas {
        key = "shop_sign",
        path = "market.png",
        px = 113,
        py = 57,
        atlas_table = 'ANIMATION_ATLAS',
        raw_key = true,
        frames = 4,
        prefix_config = { key = false }
    }
end
if BTR_config.alt_main_menu then
    SMODS.Atlas {
        key = "balatro",
        path = "bartlow.png",
        px = 333,
        py = 216,
        prefix_config = { key = false }
    }
    SMODS.current_mod.menu_cards = function ()
        for _, c in ipairs(G.title_top.cards) do
            if (c.ability.set == "Default" or c.ability.set == "Enhanced") and c.children.front then
                c.children.front.atlas = G.ASSET_ATLAS.bad_T_card
                c.children.front:set_sprite_pos({ x = 0, y = 0 })
                break
            end
        end
    end
end

--TODO: Config option to change title screen to "Because he looks like Bartlow"

--[[
if BTR_config.gameplay_changes then
    --file loading here, files for gameplay changes should all be in one folder (excl. patches obv)
   assert(SMODS.load_file("effect/joker.lua"))()
end
]]