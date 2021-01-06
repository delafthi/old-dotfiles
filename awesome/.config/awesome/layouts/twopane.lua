---------------------------------------------------------------------------
--- twopaned layouts module. Based on the tiled layouts from awful.
--
---------------------------------------------------------------------------

-- Grab environment we need
local tag = require("awful.tag")
local client = require("awful.client")
local ipairs = ipairs
local math = math
local capi =
{
    mouse = mouse,
    screen = screen,
    mousegrabber = mousegrabber
}

local twopane = {}

--- The twopane layout layoutbox icon.
-- @beautiful beautiful.layout_twopane
-- @param surface
-- @see gears.surface

--- The twopane top layout layoutbox icon.
-- @beautiful beautiful.layout_twopanetop
-- @param surface
-- @see gears.surface

--- The twopane bottom layout layoutbox icon.
-- @beautiful beautiful.layout_twopanebottom
-- @param surface
-- @see gears.surface

--- The twopane left layout layoutbox icon.
-- @beautiful beautiful.layout_twopaneleft
-- @param surface
-- @see gears.surface

--- Jump mouse cursor to the client's corner when resizing it.
-- @field awful.layout.suit.twopane.resize_jump_to_corner
twopane.resize_jump_to_corner = true

local function mouse_resize_handler(c, _, _, _, orientation)
    orientation = orientation or "twopane"
    local wa = c.screen.workarea
    local mwfact = c.screen.selected_tag.master_width_factor
    local cursor
    local g = c:geometry()
    local offset = 0
    local corner_coords
    local coordinates_delta = {x=0,y=0}

    if orientation == "twopane" then
        cursor = "cross"
        if g.height+15 > wa.height then
            offset = g.height * .5
            cursor = "sb_h_double_arrow"
        elseif not (g.y+g.height+15 > wa.y+wa.height) then
            offset = g.height
        end
        corner_coords = { x = wa.x + wa.width * mwfact, y = g.y + offset }
    elseif orientation == "left" then
        cursor = "cross"
        if g.height+15 >= wa.height then
            offset = g.height * .5
            cursor = "sb_h_double_arrow"
        elseif not (g.y+g.height+15 > wa.y+wa.height) then
            offset = g.height
        end
        corner_coords = { x = wa.x + wa.width * (1 - mwfact), y = g.y + offset }
    elseif orientation == "bottom" then
        cursor = "cross"
        if g.width+15 >= wa.width then
            offset = g.width * .5
            cursor = "sb_v_double_arrow"
        elseif not (g.x+g.width+15 > wa.x+wa.width) then
            offset = g.width
        end
        corner_coords = { y = wa.y + wa.height * mwfact, x = g.x + offset}
    else
        cursor = "cross"
        if g.width+15 >= wa.width then
            offset = g.width * .5
            cursor = "sb_v_double_arrow"
        elseif not (g.x+g.width+15 > wa.x+wa.width) then
            offset = g.width
        end
        corner_coords = { y = wa.y + wa.height * (1 - mwfact), x= g.x + offset }
    end
    if twopane.resize_jump_to_corner then
        capi.mouse.coords(corner_coords)
    else
        local mouse_coords = capi.mouse.coords()
        coordinates_delta = {
          x = corner_coords.x - mouse_coords.x,
          y = corner_coords.y - mouse_coords.y,
        }
    end

    local prev_coords = {}
    capi.mousegrabber.run(function (_mouse)
                              if not c.valid then return false end

                              _mouse.x = _mouse.x + coordinates_delta.x
                              _mouse.y = _mouse.y + coordinates_delta.y
                              for _, v in ipairs(_mouse.buttons) do
                                  if v then
                                      prev_coords = { x =_mouse.x, y = _mouse.y }
                                      local fact_x = (_mouse.x - wa.x) / wa.width
                                      local fact_y = (_mouse.y - wa.y) / wa.height
                                      local new_mwfact

                                      local geom = c:geometry()

                                      -- we have to make sure we're not on the last visible
                                      -- client where we have to use different settings.
                                      local wfact
                                      local wfact_x, wfact_y
                                      if (geom.y+geom.height+15) > (wa.y+wa.height) then
                                          wfact_y = (geom.y + geom.height - _mouse.y) / wa.height
                                      else
                                          wfact_y = (_mouse.y - geom.y) / wa.height
                                      end

                                      if (geom.x+geom.width+15) > (wa.x+wa.width) then
                                          wfact_x = (geom.x + geom.width - _mouse.x) / wa.width
                                      else
                                          wfact_x = (_mouse.x - geom.x) / wa.width
                                      end


                                      if orientation == "twopane" then
                                          new_mwfact = fact_x
                                          wfact = wfact_y
                                      elseif orientation == "left" then
                                          new_mwfact = 1 - fact_x
                                          wfact = wfact_y
                                      elseif orientation == "bottom" then
                                          new_mwfact = fact_y
                                          wfact = wfact_x
                                      else
                                          new_mwfact = 1 - fact_y
                                          wfact = wfact_x
                                      end

                                      c.screen.selected_tag.master_width_factor
                                        = math.min(math.max(new_mwfact, 0.01), 0.99)
                                      client.setwfact(math.min(math.max(wfact,0.01), 0.99), c)
                                      return true
                                  end
                              end
                              return prev_coords.x == _mouse.x and prev_coords.y == _mouse.y
                          end, cursor)
end

local function apply_size_hints(c, width, height, useless_gap)
    local bw = c.border_width
    width, height = width - 2 * bw - useless_gap, height - 2 * bw - useless_gap
    width, height = c:apply_size_hints(math.max(1, width), math.max(1, height))
    return width + 2 * bw + useless_gap, height + 2 * bw + useless_gap
end

local function twopane_group(gs, cls, wa, orientation, fact, group, useless_gap)
    -- get our orientation right
    local height = "height"
    local width = "width"
    local x = "x"
    local y = "y"
    if orientation == "top" or orientation == "bottom" then
        height = "width"
        width = "height"
        x = "y"
        y = "x"
    end

    -- make this more generic (not just width)
    local available = wa[width] - (group.coord - wa[x])

    -- find our total values
    local total_fact = 0
    local min_fact = 1
    local size = group.size
    for c = group.first,group.last do
        -- determine the width/height based on the size_hint
        local i = c - group.first +1
        local size_hints = cls[c].size_hints
        local size_hint = size_hints["min_"..width] or size_hints["base_"..width] or 0
        size = math.max(size_hint, size)

        -- calculate the height
        if not fact[i] then
            fact[i] = min_fact
        else
            min_fact = math.min(fact[i],min_fact)
        end
        total_fact = total_fact + fact[i]
    end
    size = math.max(1, math.min(size, available))

    local coord = wa[y]
    local used_size = 0
    local unused = wa[height]
    for c = group.first,group.last do
        local geom = {}
        local hints = {}
        local i = c - group.first +1
        geom[width] = size
        geom[height] = math.max(1, math.floor(unused * fact[i] / total_fact))
        geom[x] = group.coord
        geom[y] = coord
        gs[cls[c]] = geom
        hints.width, hints.height = apply_size_hints(cls[c], geom.width, geom.height, useless_gap)
        coord = coord + hints[height]
        unused = unused - hints[height]
        total_fact = total_fact - fact[i]
        used_size = math.max(used_size, hints[width])
    end

    return used_size
end

local function twopane_stack(gs, cls, wa, orientation, group)
    -- get our orientation right
    local height = "height"
    local width = "width"
    local x = "x"
    local y = "y"
    if orientation == "top" or orientation == "bottom" then
        height = "width"
        width = "height"
        x = "y"
        y = "x"
    end
    for c = group.first,group.last do
        local geom = {}
        geom[width] = group.size
        geom[height] = wa[height]
        geom[x] = group.coord
        geom[y] = wa[y]
        gs[cls[c]] = geom
    end
end

local function do_twopane(param, orientation)
    local t = param.tag or capi.screen[param.screen].selected_tag
    orientation = orientation or "right"

    -- This handles all different orientations.
    local width = "width"
    local x = "x"
    if orientation == "top" or orientation == "bottom" then
        width = "height"
        x = "y"
    end

    local gs = param.geometries
    local cls = param.clients
    local useless_gap = param.useless_gap
    local nmaster = math.min(t.master_count, #cls)
    local nother = 0
    if #cls - nmaster > 0 then nother = 1 end

    local mwfact = t.master_width_factor
    local wa = param.workarea
    local ncol = t.column_count

    local data = tag.getdata(t).windowfact

    if not data then
        data = {}
        tag.getdata(t).windowfact = data
    end

    local coord = wa[x]
    local place_master = true
    if orientation == "left" or orientation == "top" then
        -- if we are on the left or top we need to render the other windows first
        place_master = false
    end

    local grow_master = t.master_fill_policy == "expand"
    -- this was easier than writing functions because there is a lot of data we need
    for _ = 1,2 do
        if place_master and nmaster > 0 then
            local size = wa[width]
            if nother > 0 or not grow_master then
                size = math.min(wa[width] * mwfact, wa[width] - (coord - wa[x]))
            end
            if nother == 0 and not grow_master then
              coord = coord + (wa[width] - size)/2
            end
            if not data[0] then
                data[0] = {}
            end
            coord = coord + twopane_group(gs, cls, wa, orientation, data[0],
                                       {first=1, last=nmaster, coord = coord, size = size}, useless_gap)
        end

        if not place_master and nother > 0 then
            local last = nmaster

            -- we have to modify the work area size to consider left and top views
            local wasize = wa[width]
            if nmaster > 0 and (orientation == "left" or orientation == "top") then
                wasize = wa[width] - wa[width]*mwfact
            end
            local other_coord
            local other_size
            for i = 1,ncol do
                -- Try to get equal width among remaining columns
                local size = math.min( (wasize - (coord - wa[x])) / (ncol - i + 1) )
                local first = last + 1
                last = first
                -- twopane the column and update our current x coordinate
                if not data[i] then
                    data[i] = {}
                end
                other_size = size
                other_coord = coord
                coord = coord + twopane_group(gs, cls, wa, orientation, data[i],
                                           { first = first, last = last, coord = coord, size = size }, useless_gap)
            end
            if last < #cls then
                twopane_stack(gs, cls, wa, orientation,
                                           { first = last + 1, last = #cls, coord = other_coord, size = other_size })
            end
        end
        place_master = not place_master
    end

end

function twopane.skip_gap(nclients, t)
    return nclients == 1 and t.master_fill_policy == "expand"
end

--- The main twopane algo, on the right.
-- @param screen The screen number to twopane.
-- @clientlayout awful.layout.suit.twopane.right
twopane.right = {}
twopane.right.name = "twopane"
twopane.right.arrange = do_twopane
twopane.right.skip_gap = twopane.skip_gap
function twopane.right.mouse_resize_handler(c, corner, x, y)
    return mouse_resize_handler(c, corner, x, y)
end

--- The main twopane algo, on the left.
-- @param screen The screen number to twopane.
-- @clientlayout awful.layout.suit.twopane.left
twopane.left = {}
twopane.left.name = "twopaneleft"
twopane.left.skip_gap = twopane.skip_gap
function twopane.left.arrange(p)
    return do_twopane(p, "left")
end
function twopane.left.mouse_resize_handler(c, corner, x, y)
    return mouse_resize_handler(c, corner, x, y, "left")
end

--- The main twopane algo, on the bottom.
-- @param screen The screen number to twopane.
-- @clientlayout awful.layout.suit.twopane.bottom
twopane.bottom = {}
twopane.bottom.name = "twopanebottom"
twopane.bottom.skip_gap = twopane.skip_gap
function twopane.bottom.arrange(p)
    return do_twopane(p, "bottom")
end
function twopane.bottom.mouse_resize_handler(c, corner, x, y)
    return mouse_resize_handler(c, corner, x, y, "bottom")
end

--- The main twopane algo, on the top.
-- @param screen The screen number to twopane.
-- @clientlayout awful.layout.suit.twopane.top
twopane.top = {}
twopane.top.name = "twopanetop"
twopane.top.skip_gap = twopane.skip_gap
function twopane.top.arrange(p)
    return do_twopane(p, "top")
end
function twopane.top.mouse_resize_handler(c, corner, x, y)
    return mouse_resize_handler(c, corner, x, y, "top")
end

twopane.arrange = twopane.right.arrange
twopane.mouse_resize_handler = twopane.right.mouse_resize_handler
twopane.name = twopane.right.name

return twopane

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
