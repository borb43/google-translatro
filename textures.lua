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
    textures = { "bad_blinds" },
    loc_txt = {
        name = "Badly Translated",
        text = {
            "Replaces certain sprites for",
            "their google translated names",
        }
    }
}