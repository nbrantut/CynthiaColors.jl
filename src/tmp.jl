module CynthiaColors

import JSON: parsefile

rawc = JSON.parsefile("colorbrewer.json")

function ccolor(name::String, n::String)
    values = [split(strip(col,['r','g','b','(',')']),",") for col in rawc[name][n]]
    return parse.(Float64,values)/255
end

function ccolor(name::String, n::Int)
    return ccolor(name, string(n))
end

function ccolor(name::Symbol, n::Int)
    return ccolor(string(name), string(n))
end

end
