require 'set'

def link_to_code(item)
    item[:url] ||= "https://github.com/seanyeh/#{item[:title]}"
    link_to(item[:title], item[:url])
end

def gen_lang_colors(projects)
    lang_strings = projects.map{|p| p["lang"]}

    # Split lang strings and flatten to one array of all langs
    langs = lang_strings.map{|s| s.split(",")}.reduce(:+).map{|s| s.strip}

    # Remove duplicates
    langs = Set.new(langs)

    colors = gen_colors(langs.length)
    return Hash[langs.zip(colors)]
end

def gen_colors(num_colors)
    # these look good
    s = 50
    v = 70

    multiplier = 360 / num_colors
    hsv_arr = (0..num_colors-1).map{|n| [multiplier * n, s, v]}
    return hsv_arr.map{|hsv| "rgb(#{hsv_to_rgb(*hsv).join(",")})"}
end

# Ported to ruby from http://snipplr.com/view/14590/hsv-to-rgb/
def hsv_to_rgb(h, s, v)
    # # Make sure our arguments stay in-range
    h = [0, [360, h].min].max
    s = [0, [100, s].min].max
    v = [0, [100, v].min].max

    # # We accept saturation and value arguments from 0 to 100 because that's
    # # how Photoshop represents those values. Internally, however, the
    # # saturation and value are calculated from a range of 0 to 1. We make
    # # That conversion here.
    s /= 100.0
    v /= 100.0

    if s == 0
        # # Achromatic (grey)
        r = g = b = v
        return [(r * 255).round, (g * 255).round, (b * 255).round]
    end

    h /= 60.0; # sector 0 to 5
    i = h.floor
    f = h - i; # factorial part of h
    p = v * (1 - s)
    q = v * (1 - s * f)
    t = v * (1 - s * (1 - f))

    if i == 0
        r = v
        g = t
        b = p
    elsif i == 1
        r = q
        g = v
        b = p
    elsif i == 2
        r = p
        g = v
        b = t
    elsif i == 3
        r = p
        g = q
        b = v
    elsif i == 4
        r = t
        g = p
        b = v
    else # i == 5
        r = v
        g = p
        b = q
    end

    return [(r * 255).round, (g * 255).round, (b * 255).round]
end
