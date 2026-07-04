AltTexture {
    key = "tarots",
    set = "Tarot",
    path = "consumables.png",
    loc_txt = {
        name = "Badly Translated Tarots"
    },
    original_sheet = true,
    keys = { "c_high_priestess", "c_empress", "c_heirophant", "c_lovers", "c_chariot", "c_justice", "c_hermit", "c_strength", "c_hanged_man", "c_temperance", "c_tower", "c_star", "c_sun", "c_judgement", }
}

AltTexture {
    key = "planets",
    set = "Planet",
    path = "consumables.png",
    loc_txt = {
        name = "Badly Translated Planets"
    },
    original_sheet = true,
    keys = { "c_eris", "c_ceres", "c_planet_x", "c_earth", "c_jupiter", }
}

AltTexture {
    key = "spectrals",
    set = "Spectral",
    path = "consumables.png",
    loc_txt = {
        name = "Badly Translated Spectrals"
    },
    original_sheet = true,
    keys = { "c_soul", "c_familiar", "c_grim", "c_incantation", "c_talisman", "c_aura", "c_wraith", "c_sigil", "c_immolate", "c_ankh", "c_hex", "c_trance", "c_medium", "c_cryptid", }
}

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
    loc_txt = {
        name = "Badly Translated Blinds"
    },
    animated = true,
}

TexturePack {
    key = "badly_translated",
    textures = { "bad_tarots", "bad_planets", "bad_coupons", "bad_blinds", "bad_jokers", },
    loc_txt = {
        name = "Badly Translated",
        text = {
            "Replaces certain sprites for",
            "their google translated names",
        }
    }
}