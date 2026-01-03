SMODS.Joker:take_ownership("joker", {
    loc_vars = function(self, info_queue, card)
        local vars = {card.ability.mult,}
        -- oh god im going to have to repeat this line so many times
        info_queue[#info_queue + 1] = {set = "Other", key = self.key, specific_vars = vars}

        return { vars = vars }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return { mult_mod = card.ability.mult - mult }
        end
    end
})

SMODS.Joker:take_ownership("greedy_joker", {
    loc_vars = function(self, info_queue, card)
        local vars = {card.ability.extra.s_mult,}
        info_queue[#info_queue + 1] = {set = "Other", key = "gt_unchanged"}

        return { vars = vars }
    end
})

SMODS.Joker:take_ownership("lusty_joker", {
    loc_vars = function(self, info_queue, card)
        local vars = {card.ability.extra.s_mult,}
        info_queue[#info_queue + 1] = {set = "Other", key = "gt_nop"}

        return { vars = vars }
    end,

    calculate = function(self, card, context) return end
})

