-- Floating terminal window rule

o.window("^(kitty)$", {
    float = true,
    size = "800 600",
    center = true,
})

-- btop launched with SUPER + SHIFT + T
o.window("^(btop-float)$", { tag = "+terminal" })
o.window("^(btop-float)$", { float = true })
o.window("^(btop-float)$", { size = "800 600" })
o.window("^(btop-float)$", { center = true })
