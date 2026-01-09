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
        calculate = function(self, card, context) return end
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

            return
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
        end
    },

    {
        key = "crazy",
        
        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_mult}
            return {vars = vars}
        end,

        calculate = function(self, card, context) return end
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
                    if SMODS.has_no_suit(playing_card) then return end
                    
                    -- why is there no continue :(
                    if not SMODS.has_any_suit(playing_card) then
                        if not t_suit then t_suit = playing_card.base.suit end
                        if not playing_card:is_suit(t_suit) then return end
                    end


                end

                return { chips = card.ability.t_chips }
            end
        end
    },

    {
        key = "wily",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_chips}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                local _, _, _parts = G.FUNCS.get_poker_hand_info(G.deck.cards)
                if next(_parts["Three of a Kind"]) then
                    return { chips = card.ability.t_chips }
                end
            end
        end
    },

    {
        key = "clever",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_chips,}
            return {vars = vars}
        end
    },

    {
        key = "devious",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_chips,}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
                return { chips = card.ability.t_chips }
            end
        end
    },

    {
        key = "crafty",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.t_chips,}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.joker_main and G.GAME.current_round.hands_left == 0 then
                SMODS.add_card{ set = "Playing Card", rank = "A" }
                return { chips = card.ability.t_chips }
            end
        end
    },

    {
        key = "half",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra.mult, card.ability.extra.size}
            return {vars = vars}
        end
    },

    {
        key = "stencil",

        loc_vars = function(self, info_queue, card)
            card.ability.bonusmult = card.ability.bonusmult or 1
            local vars = {card.ability.bonusmult}
            return {vars = vars}
        end,

        calculate = function(self, card, context)

            if context.setting_blind then
                local open_slots = G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)
                if open_slots < 1 then return 0 end
                G.GAME.joker_buffer = G.GAME.joker_buffer + open_slots

                G.E_MANAGER:add_event(Event({
                    func = function()
                        for bonus = 1, open_slots do
                            local child = SMODS.add_card { key = card.config.center.key, key_append = "gt_stencil"}
                            child.ability.bonusmult = (card.ability.bonusmult or 1) + bonus

                            G.GAME.joker_buffer = 0
                        end

                        return true
                    end
                }))

                return { message = localize("k_plus_joker"), colour = G.C.BLUE }
            end

            if context.joker_main then
                return { xmult = card.ability.bonusmult }
            end
        end
    },

    {
        key = "four_fingers",

        calculate = function(self, card, context)
            if context.remove_playing_cards and not G.GAME.gt_ff_firing then
                local bloodlust = 4 - #context.removed
                if bloodlust < 1 then return end

                -- theres no way to set a calc context for destroy_cards
                -- so heres how we prevent an inf loop
                G.GAME.gt_ff_firing = true
                for i = 1, bloodlust do
                    local sac = pseudorandom_element(G.deck.cards, "gt_four_fingers")
                    if not sac.destroyed and not sac.getting_sliced then SMODS.destroy_cards(sac) end
                end
                G.GAME.gt_ff_firing = false

                return { message = localize("k_extinct_ex") }
            end

            if context.end_of_round then G.GAME.gt_ff_firing = false end
        end
    },

    {
        key = "mime",

        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.hand and not context.end_of_round then
                if SMODS.has_no_rank(context.other_card) then return end
                return { message = localize(context.other_card.base.value, "ranks") }
            end
        end
    },

    {
        key = "credit_card",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra}
            return {vars = vars}
        end
    },

    {
        key = "ceremonial",
        effect_key = "gt_nop",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra,}
            return { vars = vars }
        end,
        calculate = function(self, card, context) return end
    },

    {
        key = "banner",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra,}
            return { vars = vars }
        end,

        calculate = function(self, card, context)
            if context.end_of_round and context.main_eval and not context.beat_boss and not context.game_over then
                local newtag = "UNAVAILABLE"
                local it = 1

                while newtag == "UNAVAILABLE" do
                    newtag = pseudorandom_element(get_current_pool("Tag"), "gt_banner"..it)
                    it = it + 1
                end

                add_tag(Tag(newtag, false, "Small"))
                return { message = localize("k_active_ex") }
            end
        end
    },

    {
        key = "mystic_summit",
        effect_key = "gt_nop",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra.mult,}
            return { vars = vars }
        end,

        calculate = function(self, card, context) return end
    },

    {
        key = "marble",
        effect_key = "gt_unchanged"
    },

    {
        key = "loyalty_card",
        set_ability = function(self, card) card.ability.loyalty_remaining = card.ability.extra.every end,

        loc_vars = function(self, info_queue, card)
            local vars = {
                card.ability.extra.Xmult,
                card.ability.extra.every + 1,
                localize{ type = "variable", key = "loyalty_inactive", vars = {card.ability.loyalty_remaining} },
                card.ability.loyalty_remaining
            }
            return { vars = vars }
        end,

        calculate = function(self, card, context)
            if context.before then
                -- idk what this really means (copied from the source code)
                card.ability.loyalty_remaining = (card.ability.extra.every - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) % (card.ability.extra.every + 1)

                if card.ability.loyalty_remaining == card.ability.extra.every then
                    ease_hands_played(3)
                    return { message = localize("k_active_ex"), colour = G.C.BLUE }
                end
            end
        end
    },

    {
        key = "8_ball",
        set_ability = function(self, card) card.ability.gt_remaining = 8 end,

        loc_vars = function(self, info_queue, card)
            local num, den = SMODS.get_probability_vars(self, 1, card.ability.extra, "gt_8_ball")
            local vars = { num, den, card.ability.gt_remaining }
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            local newsum = 0
            if context.hand_drawn then newsum = newsum + #context.hand_drawn end
            if context.other_drawn then newsum = newsum + #context.other_drawn end
            if context.before then newsum = newsum + #context.full_hand end

            card.ability.gt_remaining = card.ability.gt_remaining - newsum
            if card.ability.gt_remaining < 1 then
                card.ability.gt_remaining = 8
                if not SMODS.pseudorandom_probability(card, "gt_8_ball", 1, card.ability.extra) then print("failed"); return end

                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    message = localize("k_plus_tarot"),
                    func = function()
                        SMODS.add_card{ set = "Tarot", key_append = "gt_8_ball" }
                        G.GAME.consumeable_buffer = 0

                        return true
                    end
                }
            end
        end
    },

    {
        key = "misprint",
        effect_key = "gt_unchanged",
        vanilla_code = true,     -- i am NOT touching dynatext
    },

    {
        key = "dusk",
        -- this is all handled in the play_cards_from_highlighted hook below
    },

    {
        key = "raised_fist",
        effect_key = "gt_nop",

        calculate = function(self, card, context) return end
    },

    {
        key = "chaos",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra,}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.starting_shop then 
                card.ability.gt_valueget = true
                local eval = function(card) return card.ability.gt_valueget and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
            end

            if context.ending_shop then card.ability.gt_valueget = false end

            if context.selling_card and card.ability.gt_valueget then
                local value = context.card.sell_cost
                if value < 1 then return end
                ease_dollars(value)
                card.ability.gt_valueget = false
            end
        end
    },

    {
        key = "fibonacci",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra}
            return {vars = vars}
        end,
    },

    {
        key = "steel_joker",

        loc_vars = function(self, info_queue, card)
            local decksize = (G.deck and G.deck.cards) and #G.deck.cards or 52
            local vars = {card.ability.extra, card.ability.extra * decksize}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.joker_main then
                return { xmult = card.ability.extra * #G.deck.cards }
            end
        end
    },

    {
        key = "scary_face",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra,}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if
                    next(SMODS.get_enhancements(context.other_card))
                    or context.other_card.edition
                    or context.other_card.seal
                    or context.other_card.ability.rental    -- idk if playing cards can get rental but...
                then
                    return { dollars = card.ability.extra }
                end
            end
        end
    },

    {
        key = "abstract",

        loc_vars = function(self, info_queue, card)
            local jokercount = G.jokers and G.jokers.cards and #G.jokers.cards or 0
            local vars = {card.ability.extra, jokercount * card.ability.extra}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play
                and SMODS.has_enhancement(context.other_card, "m_wild") then

                return { mult = card.ability.extra }
            end
        end
    },

    {
        key = "delayed_grat",

        loc_vars = function(self, info_queue, card)
            local active_text = "inactive"
            local active_color = G.C.UI.TEXT_INACTIVE

            if card.ability.gt_active then
                active_text = "active"
                active_color = G.C.RED
            end

            local vars = {card.ability.extra, active_text, colours = {active_color,}}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.end_of_round then
                card.ability.gt_active = G.GAME.current_round.discards_used <= 0
            end

            if context.discard and card.ability.gt_active then
                local newvalue = context.other_card.ability.perma_p_dollars or 0
                context.other_card.ability.perma_p_dollars = newvalue + card.ability.extra
                return { message = localize("k_upgrade_ex") }
            end
        end
    },

    {
        key = "hack",
        effect_key = "gt_nop",

        calculate = function(self, card, context) end
    },

    {
        key = "pareidolia",

        add_to_deck = function(self, card, from_debuff)
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in pairs(G.I.CARD) do
                        if v.set_cost then v:set_cost() end
                    end

                    return true
                end
            }))
        end,

        remove_from_deck = function(self, card, from_debuff)
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in pairs(G.I.CARD) do
                        if v.set_cost then v:set_cost() end
                    end

                    return true
                end
            }))
        end
    },

    {
        key = "gros_michel",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra.mult}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.mod_probability and not context.blueprint then
                return { numerator = context.numerator + card.ability.extra.mult }
            end

            if context.joker_main then
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.gros_michel_extinct = true
                return { message = localize("k_extinct_ex") }
            end
        end
    },

    {
        key = "even_steven",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.discard then
                local rank = context.other_card:get_id()
                if rank <= 10 and rank >= 0 and rank % 2 == 0 then
                    return { mult = card.ability.extra }
                end
            end
        end
    },

    {
        key = "odd_todd",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and #context.full_hand < 2 then
                return { chips = card.ability.extra }
            end
        end
    },

    {
        key = "scholar",

        loc_vars = function(self, info_queue, card)
            local vars = {
                card.ability.extra.mult, card.ability.extra.chips,
                card.ability.extra.mult + card.ability.extra.chips }
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
                return { chips = card.ability.extra.mult + card.ability.extra.chips }
            end
        end
    },

    {
        key = "business",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra, "gt_business")
            local vars = {num, den}
            return {vars = vars}
        end
    },

    {
        key = "supernova",

        calculate = function(self, card, context)
            if context.joker_main then
                return { message = tostring(G.GAME.hands_played + 1) }
            end
        end
    },

    {
        key = "ride_the_bus",

        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra, card.ability.mult}
            return {vars = vars}
        end,

        calculate = function(self, card, context)
            if context.before then
                if #G.hand.cards == 0 then card.ability.gt_active = true end
                if card.ability.gt_active then card.ability.mult = card.ability.mult + card.ability.extra end
                return { message = localize("k_upgrade_ex") }
            end

            if context.joker_main then
                return { mult = card.ability.mult }
            end

            if context.end_of_round and context.beat_boss then
                card.ability.gt_active = false
            end
        end
    },

    {
        key = "space",
        effect_key = "gt_unchanged",

        loc_vars = function(self, info_queue, card)
            local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra, "gt_business")
            local vars = {num, den}
            return {vars = vars}
        end
    },

    {
        key = "egg",
        vanilla_code = true,    -- essentially vanilla, all the extra effects are through ext hooks
        
        loc_vars = function(self, info_queue, card)
            local vars = {card.ability.extra}
            return {vars = vars}
        end,
    }
}


-- patch for four_fingers
-- so it doesnt do anything for flush
-- also its broken under cryptid because they dont know
-- what the call sig for four_fingers is supposed to be
local ff_ref = SMODS.four_fingers
function SMODS.four_fingers(hand_type)
    if hand_type == "flush" then return 5 end
    return ff_ref(hand_type)
end


-- hook for dusk
-- modifying the cards that are played is VERY tricky
local pch_ref = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    if not next(SMODS.find_card("j_dusk")) then return pch_ref(e) end
    -- because this is BEFORE the hand is played...
    if G.GAME.current_round.hands_left > 1 then return pch_ref(e) end
    SMODS.change_play_limit(999)

    for _, playing_card in ipairs(G.hand.cards) do
        G.E_MANAGER:add_event(Event({
            trigger = "after", delay = 0.03,
            func = function()
                if playing_card.highlighted then return true end
                G.hand:add_to_highlighted(playing_card)
                return true
            end
        }))
    end

    G.E_MANAGER:add_event(Event({
        func = function()
            SMODS.change_play_limit(-999)
            pch_ref(e)
            return true
        end
    }))
end

-- patch for paredolia
-- sets all vouchers to free, similar to astronomoer
-- patch for egg
-- discount of $3 for all items
local sc_ref = Card.set_cost
Card.set_cost = function(self)
    sc_ref(self)

    if next(SMODS.find_card("j_pareidolia")) and self.ability.set == "Voucher" then
        self.cost = 0 
        -- you cant sell vouchers so no need to set sell cost
    end

    -- yea its a bit jank but hey it works
    for _, egg in ipairs(SMODS.find_card("j_egg")) do
        self.cost = math.max(self.cost - egg.ability.extra, 0)
    end
end



for _, t in ipairs(towns) do
    local key = t.key
    if t.vanilla_code then key = nil end

    SMODS.Joker:take_ownership(t.key, {
        name = key,    -- vanilla calcs check the name for some reason lol
        set_ability = t.set_ability,
        calculate = t.calculate,
        add_to_deck = t.add_to_deck,
        remove_from_deck = t.remove_from_deck,

        loc_vars = function(self, info_queue, card)
            local vars = {}
            if t.loc_vars then
                vars = t.loc_vars(self, info_queue, card)
            end

            info_queue[#info_queue + 1] = {
                set = "Other", key = t.effect_key or "j_" .. t.key, specific_vars = vars.vars
            }

            return vars
        end
    })
end
