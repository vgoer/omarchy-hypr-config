-- Official Hyprland custom layout example.
-- Source: https://github.com/hyprwm/Hyprland/blob/main/example/layouts/grid.lua
-- Selectable as "lua:grid".

hl.layout.register("grid", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then
            return
        end

        local cols = math.ceil(math.sqrt(n))

        for i, target in ipairs(ctx.targets) do
            target:place(ctx:grid_cell(i, cols))
        end
    end,
})
