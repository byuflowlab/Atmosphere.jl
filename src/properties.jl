#Define Properties Constants
const Tsl = 288.15  #sea level temperature (K)
const Psl = 101325.0 #sea level pressure (Pa)
const musl = 0.0000181206  #sea level viscosity (N-s/m^2)
const Sc = 110.0  #constant in Sutherlands formula (K)
const gamma = 1.4  #ratio of specific heats (air)
const R_M = 287.0520809957016 #Molar Gas Constant: R (gas constant) = 8.31432e3 #N m kmol−1 K−1, M (mean molar mass) = 28.9645 #g/mol, R_M = R/M
const earthradius = 6369.0e3 #radius of the earth (m)
const gravity = 9.81
"""
    atmospherefit(altitude::Float64)

Return density (kg/m^3), viscosity (Pa-s), and speed of sound (m/s) functions.

Employ fits to Standard Atmosphere model. Input altitude must be in meters.
"""
function atmospherefit(altitude::Float64)

	T, P = temp_presfit(altitude)
	rho = density(T, P)
	mu = viscosity(T)
	a = speedofsound(T)

    return rho, mu, a

end #atmospherefit

"""
	temp_presfit(altitude::Float64)

Calculate atmospheric temperature and pressure for input altitude (meters) using fits of the standard atmosphere model,
slightly modified from those found in Flight Vehicle Aerodynamics by Mark Drela.

"""
function temp_presfit(altitude::Float64)

	#Convert Altitude to km
	altkm = altitude/1000

	T = Tsl - 71.5 + 2*log(1+exp(35.75-3.25*(altkm))+exp(-3.0+0.0003*(altkm)^3))
	P = Psl*exp(-0.118*(altkm)-(0.0015*(altkm)^2)/(1-0.018*(altkm)+0.0011*(altkm)^2))

	return T, P

end #temp_presfit

"""
	atmospheretable(altitude::Float64)

Return density (kg/m^3), viscosity (Pa-s), and speed of sound (m/s) functions.

Input altitude must be in meters.
"""
function atmospheretable(altitude::Float64)
	if altitude > 86000
		warn("air properties for altitudes above 86000 meters will be innacurate.")
	end

	T, P = temp_prestable(altitude)
	rho = density(T, P)
	mu = viscosity(T)
	a = speedofsound(T)

	return rho, mu, a

end #atmospherefit

"""
	temp_prestable(altitude::Float64)

Return Temperature (K) and Pressure (Pa) values based on fit to Standard Atmosphere Model.

The fit is a slightly modified version of that found in Flight Vehicle Aerodynamics by Mark Drela. Input altitude must be in meters.
"""
function temp_prestable(altitude::Float64)
	#Convert Geometric Altitude to Geopotential Altitude
	altgeopot = altitude*earthradius/(altitude+earthradius)

	#table values
	altitudetable = [0.0, 11.0, 20.0, 32.0, 47.0, 51.0, 71.0, 84.852]*1e3
	temperaturetable = [288.15, 216.65, 216.65, 228.65, 270.65, 270.65, 214.65, 186.946]
	temperaturegradient = [-6.5, 0.0, 1.0, 2.8, 0.0, -2.8, -2.0, 0.0]*1e-3
	pressuretable = [101325.0, 22620.36, 5469.378, 866.5941, 110.6457, 66.76995, 3.942586, 0.371775]

	#find relavent index in tables
	idx = find(altitudetable.<=altgeopot)[end]

	#find temperature
	T = temperaturetable[idx] + (altgeopot-altitudetable[idx])*temperaturegradient[idx]

	#find pressure
	if temperaturegradient[idx] == 0.0
		P = pressuretable[idx]*exp(-gravity*(altgeopot-altitudetable[idx])/R_M/temperaturetable[idx])
	else
		P = pressuretable[idx]*(temperaturetable[idx]/T)^(gravity/R_M/temperaturegradient[idx])
	end

	return T, P

end

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
