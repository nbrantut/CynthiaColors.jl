module CynthiaColors

import JSON: parsefile
export ccolor, ccolorlist

const rawc = parsefile(joinpath(dirname(pathof(CynthiaColors)), "colorbrewer.json"))

"""
    ccolor(name::String, n::String)

Return list of normalised rgb color with name 'name' and 'n' number of tones.
"""
function ccolor(name::String, n::String)
    values = [split(strip(col,['r','g','b','(',')']),",") for col in rawc[name][n]]
    return [parse.(Float64,val)/255 for val in values]
end

"""
    ccolor(name::String, n::Int)

Return list of normalised rgb color with name 'name' and 'n' number of tones.
"""
function ccolor(name::String, n::Int)
    return ccolor(name, string(n))
end

"""
    ccolor(name::Symbol, n::Int)

Return list of normalised rgb color with name 'name' and 'n' number of tones.
"""
function ccolor(name::Symbol, n::Int)
    return ccolor(string(name), string(n))
end

"""
    ccolorlist(type="all")

Return list of colorschemes with 'type'.
"""
function ccolorlist(type="all")
    println("name     type   min/max")
    println("-----------------------")
    for k in keys(rawc)
        typ = rawc[k]["type"]
        if (type=="all") | (typ==type)
            subk = keys(rawc[k])        
            num = parse.(Int, collect(subk)[findall(subk .!= "type")])
            println(rpad(k,8), " ", rpad(typ,6), " ", extrema(num))
        end
    end
end

end # module
