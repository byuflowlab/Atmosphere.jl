"Atmosphere: Used to calculate values for air density, dynamic viscosity, and speed of sound according to the NASA 1976 Standard Atmosphere.

Constains the Functions:\\
-atmosphere (main)\\
-temp_presdrela (default fit)\\
-tem_presnasa\\
-density\\
-viscosity\\
-speedofsound"
module Atmosphere
export atmosphere

"
```julia
atmosphere(altitude::Float64 [,style::String])
```

Calls fits, density, viscosity, and speed of sound functions.

Input: altitude in meters, style (optional) - \"drelafit\" -> temperature and pressure fits by Dr. Mark Drela (default), \"nasa\" (or anything else) -> temperature and pressure fits by NASA.

Output: air density (kg/m^3), air dynmaic viscosity (Ns/m), speed of sound (m/s)"
function atmosphere(altitude::Float64,style::String="drelafit")

    if style == "drelafit"
        T,P = temp_presdrela(altitude)
    else
        T,P = temp_presnasa(altitude)
    end #if style

    rho = density(T,P)
    mu = viscosity(T)
    a = speedofsound(T)

    return rho,mu,a

end #atmosphere


"
```julia
temp_presdrela(altitude::Float64)
```

Standard Atmosphere model fits for Temperature and Pressure, modified slightly from Flight Vehicle Aerodynamics by Mark Drela.

Input: altitude in meters

Output: Temperature in Kelvin, Pressure in Pascals"
function temp_presdrela(altitude::Float64)
    #Define Constants
    Tsl = 288.15  #sea level temperature (K)
    Psl = 101325 #sea level pressure (Pa)

    #Temperature and Pressure Fits
    T = Tsl - 71.5 + 2*log(1+exp(35.75-3.25*(altitude/1000))+exp(-3.0+0.0003*(altitude/1000)^3))
    P = Psl*exp(-0.118*(altitude/1000)-(0.0015*(altitude/1000)^2)/(1-0.018*(altitude/1000)+0.0011*(altitude/1000)^2))

    return T,P
end #temp_presdrela()


"
```julia
temp_presnasa(altitude::Float64)
```

Standard Atmosphere model fits for Temperature and Pressure, obtained from the NASA website.

Input: altitude in meters

Output: Temperature in Kelvin, Pressure in Pascals"
function temp_presnasa(altitude::Float64)
    #Tempurature and Pressure Fits
    if altitude<= 11000
        T = 15.04 - .00649*altitude+ 273.1 #units: K
        P = 1000*(101.29*(T/288.08)^5.256) #units: Pa
    elseif (altitude> 11000) && (altitude<= 25000)
        T = -56.46 + 273.1 #units: K
        P = 1000*(22.65*exp(1.73 - 0.000157*altitude)) #units: Pa
    else #altitude> 25000
        T = -131.21 + 0.00299*altitude+ 273.1 #units: K
        P = 1000*(2.488/((T/216.6)^11.388)) #units: Pa
    end

    return T,P

end #temp_presnasa()


"
```julia
density(Temperature::Float64,Pressure::Float64)
```

Ideal Gas Law solving for density.

Input: Temperature in Kelvin, Pressure in Pascals

Output: Density in kilogram per meter cubed"
function density(Temperature::Float64,Pressure::Float64)
    #Ideal Gas Law
    rho = Pressure/(287.0520809957016*Temperature) #units: kg/m^3
    return rho
end #density()


"
```julia
speedofsound(Temperature::Float64)
```

Ideal Gas Law solving for speed of sound.

Input: Temperature in Kelvin

Output: Speed of Sound in meters per second"
function speedofsound(Temperature::Float64)
    gamma = 1.4  #ratio of specific heats (air)
    R_M = 287.0520809957016 #Molar Gas Constant/Mean Molar Mass of dry air 287.058
    #speed of sound (ideal gas law)
    a = sqrt(gamma*R_M*Temperature)
    return a
end #speedofsound()


"
```julia
viscosity(Temperature::Float64)
```

Sutherlands Equation for Dynamic Viscosity

Input: Temperature in Kelvin

Output: Dynamic Viscosity in Pascal seconds (Newton seconds per meter squared)"
function viscosity(Temperature::Float64)
    Tsl = 288.15  #sea level temperature (K)
    musl = 0.0000181206  #sea level viscosity (N-s/m^2)
    Sc = 110.4  #constant in Sutherlands formula
    mu = musl*(Temperature/Tsl)^(3.0/2)*(Tsl+Sc)/(Temperature+Sc) #Pa-s
    return mu
end #viscosity()

end #module Atmosphere
