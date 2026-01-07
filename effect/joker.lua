-- TakeOWNershipS
local towns = {
    {
        key = "joker",

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.mult,}}
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                return { mult_mod = card.ability.mult - mult, message = localize("k_active_ex") }
            end

            return 0
        end
    },

    {
        key = "greedy_joker",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra.s_mult,}
            return {vars = vars}
        end
    },

    {
        key = "lusty_joker",
        effect_key = "gt_nop",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra.s_mult,}
            return { vars = vars }
        end,
        calculate = function(self, card, context) return 0 end
    },

    {
        key = "wrathful_joker",
        
        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra.s_mult,}
            return { vars = vars }
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                for _, playing_card in ipairs(context.full_hand) do
                    if playing_card:is_suit("Spades") then
                        return { mult = card.ability.extra.s_mult }
                    end
                end
            end

            -- take ownership runs the original code if null is returned...
            return 0
        end
    },

    {
        key = "gluttenous_joker",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra.s_mult,}
            return {vars = vars}
        end
    },

    {
        -- m
        key = "jolly",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_mult}
            return {vars = vars}
        end,
        
        calculate = function(self, card, context)
            if context.joker_main then
                -- classic :)
                if #context.full_hand % 2 == 0 then
                    return { mult = card.ability.t_mult }
                end
            end

            return 0
        end
    },

    {
        key = "zany",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_mult}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                local _, _, _parts = G.FUNCS.get_poker_hand_info(G.hand.cards)
                if next(_parts["Three of a Kind"]) then
                    return { mult = card.ability.t_mult }
                end
            end

            return 0
        end
    },

    {
        key = "mad",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_mult}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                if G.GAME.hands["Two Pair"] and G.GAME.hands["Two Pair"].played_this_round > 1 then
                    return { mult = card.ability.t_mult }
                end
            end

            return 0
        end
    },

    {
        key = "crazy",
        
        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_mult}
            return {vars = vars}
        end,

        calculate = function(self, card, context) return 0 end
    },

    {
        key = "droll",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_mult,}
            return {vars = vars}
        end
    },

    {
        key = "sly",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_chips,}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                local t_suit = nil

                for _, playing_card in ipairs(context.scoring_hand) do
                    if SMODS.has_no_suit(playing_card) then return 0 end
                    
                    -- why is there no continue :(
                    if not SMODS.has_any_suit(playing_card) then
                        if not t_suit then t_suit = playing_card.base.suit end
                        if not playing_card:is_suit(t_suit) then return 0 end
                    end


                end

                return { chips = card.ability.t_chips }
            end
        end
    }
}

for _, t in ipairs(towns) do
    SMODS.Joker:take_ownership(t.key, {
        loc_vars = function(self, info_queue, card)
            if not t.loc_vars then return 0 end
            local vars = t.loc_vars(self, info_queue, card)
            if not vars or not vars.vars then return 0 end

            info_queue[#info_queue + 1] = {
                set = "Other", key = t.effect_key or "j_" .. t.key, specific_vars = vars.vars
            }

            return vars
        end,

        calculate = t.calculate
    })
end
