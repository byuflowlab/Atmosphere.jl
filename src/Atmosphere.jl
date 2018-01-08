"
    Atmosphere
Calculate values for air density, dynamic viscosity, and speed of sound.

# Methods
- atmospherefit
- temp_presdrela
- temp_presnasa
- density
- viscosity
- speedofsound"
module Atmosphere
export atmosphere

#Define Constants
const Tsl = 288.15  #sea level temperature (K)
const Psl = 101325.0 #sea level pressure (Pa)
const musl = 0.0000181206  #sea level viscosity (N-s/m^2)
const Sc = 110.0  #constant in Sutherlands formula (K)
const gamma = 1.4  #ratio of specific heats (air)
const R_M = 287.0520809957016 #Molar Gas Constant/Mean Molar Mass of dry air

"""
    atmospherefit(altitude::Float64)

Return density (kg/m^3), viscosity (Pa-s), and speed of sound (m/s) functions.

Employ fits to Standard Atmosphere model. Input altitude must be in meters.
"""
function atmospherefit(altitude::Float64)

    T, P = temp_presdrela(altitude)
    rho = density(T, P)
    mu = viscosity(T)
    a = speedofsound(T)

    return rho, mu, a

end #atmospherefit


"""
    temp_presdrela(altitude::Float64)

Return Temperature (K) and Pressure (Pa) values based on fit to Standard Atmosphere Model.

The fit is a slightly modified version of that found in Flight Vehicle Aerodynamics by Mark Drela. Input altitude must be in meters.
"""
function temp_presdrela(altitude::Float64)
    #Convert Altitude to km
    altkm = altitude/1000

    #Temperature and Pressure Fits
    T = Tsl - 71.5 + 2*log(1+exp(35.75-3.25*(altkm))+exp(-3.0+0.0003*(altkm)^3))
    P = Psl*exp(-0.118*(altkm)-(0.0015*(altkm)^2)/(1-0.018*(altkm)+0.0011*(altkm)^2))

    return T, P
end #temp_presdrela()

#TODO check actual std atm source and update this function accordingly, also create an atmospherestd() function analogous to atmospherefit() above
# """
#      temp_presnasa(altitude::Float64)
#
# Standard Atmosphere model fits for Temperature and Pressure, obtained from the NASA website.
#
# """
# function temp_presnasa(altitude::Float64)
#     #Tempurature and Pressure Fits
#     if altitude < -1000.0
#         warn("Atmosphere model invalid for altitudes below -1,000 meters.")
#     elseif (altitude >= -1000.0) && (altitude <= 11000.0)
#         T = 15.04 - .00649*altitude + 273.1 #units: K
#         P = 1000*(101.29*(T/288.08)^5.256) #units: Pa
#     elseif (altitude > 11000) && (altitude <= 25000)
#         T = -56.46 + 273.1 #units: K
#         P = 1000*(22.65*exp(1.73 - 0.000157*altitude)) #units: Pa
#     elseif (altitude > 25000) && (altitude <= 85000)
#         T = -131.21 + 0.00299*altitude + 273.1 #units: K
#         P = 1000*(2.488/((T/216.6)^11.388)) #units: Pa
#     else
#         warn("Atmosphere model invalid for altitudes above 85,000 meters.")
#     end
#
#     return T, P
#
# end #temp_presnasa()


"""
    density(Temperature::Float64, Pressure::Float64)

Return Air Density (kg/m^3) from Ideal Gas Law.

Input Temperature must be in Kelvin, and Input Pressure must be in Pascals.
"""
function density(Temperature::Float64, Pressure::Float64)
    #Ideal Gas Law
    rho = Pressure/(R_M*Temperature)
    return rho
end #density()


"""
    speedofsound(Temperature::Float64)

Return Speed of Sound (m/s) from Ideal Gas Law.

Input Temperature must be in Kelvin.
"""
function speedofsound(Temperature::Float64)
    #speed of sound (ideal gas law)
    a = sqrt(gamma*R_M*Temperature)
    return a
end #speedofsound()


"""
    viscosity(Temperature::Float64)

Return Dynamic Viscosity (Pa-s) from Sutherlands Equation.

Input Temperature must be in Kelvin.
"""
function viscosity(Temperature::Float64)
    mu = musl*(Temperature/Tsl)^(3.0/2)*(Tsl+Sc)/(Temperature+Sc)
    return mu
end #viscosity()

end #module Atmosphere
