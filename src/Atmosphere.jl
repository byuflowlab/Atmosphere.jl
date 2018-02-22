"
    Atmosphere

Functions concerning atmospheric conditions: air properites, velocities, etc.

# properties

Calculate values for air density, dynamic viscosity, and speed of sound.

## Methods
- atmospherefit
- temp_presdrela
- temp_presnasa
- density
- viscosity
- speedofsound

# wind models

"
module Atmosphere
import ForwardDiff
import DiffResults

include("properties.jl")
include("propertiesderiv.jl")
include("wind.jl")

end #module Atmosphere
