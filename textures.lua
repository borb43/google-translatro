AltTexture {
    key = "coupons",
    set = "Voucher",
    path = "coupons.png",
    loc_txt = {
        name = "Vouchers to Coupons"
    }
}

AltTexture {
    set = "Joker",
    path = "jokers.png",
    key = "jokers",
    keys = { "j_caino", "j_triboulet", "j_yorick", "j_chicot", "j_perkeo", },
    soul_keys = { "j_caino", "j_triboulet", "j_yorick", "j_chicot", "j_perkeo", },
    display_pos = { x = 0, y = 0, },
    loc_txt = {
        name = "Badly Translated Legendaries"
    },
}

AltTexture {
    set = 'Blind',
    path = "blinds.png",
    key = "blinds",
    keys = { "bl_small", "bl_big", },
    original_sheet = true,
    display_pos = { x = 0, y = 0, },
    loc_txt = {
        name = "Badly Translated Blinds"
    },
    animated = true,
}

TexturePack {
    key = "badly_translated",
    textures = { "bad_coupons", "bad_blinds", "bad_jokers", },
    loc_txt = {
        name = "Badly Translated",
        text = {
            "Replaces certain sprites for",
            "their google translated names",
        }
    }
}