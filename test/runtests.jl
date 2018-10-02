using Atmosphere
using Test

@testset "Temperature and Pressure: Fit" begin

	#---Parameters, Inputs, etc.
	h = [0.0; 5004.0; 11019.0; 15035.0; 20063.0; 26107.0; 32162.0; 39241.0; 47350.0]#[0.0; 5.0; 11.0; 15.0; 20.0; 26.0; 32.0; 39.0; 47.0]*1e3

	#values from the 1976 US Standard Atmosphere Data https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf, Table 1: Geopotential Altitdue, H
	Tcheck = [288.150; 255.650; 216.650; 216.650; 216.650; 222.650; 228.650; 248.250; 270.650] #K
	Pcheck = [101325.0; 54019.0; 22632.0; 12044.0; 5474.8; 2153.0; 868.01; 318.22; 110.90] #Pa

	#---Run Function/Tests
	for i=1:length(h)
		T,P = Atmosphere.temp_presfit(h[i])
		@test isapprox(T, Tcheck[i], atol=3.75)
		@test isapprox(P, Pcheck[i], atol=1.0825e2)
	end #for length h

end #Temp and Pres: Fit

@testset "Temperature and Pressure: Table" begin

	#---Parameters, Inputs, etc.
	h = [0.0; 5004.0; 11019.0; 15035.0; 20063.0; 26107.0; 32162.0; 39241.0; 47350.0; 49381.0; 51413.0; 61591.0; 71802.0; 78969.0; 85638.0]
	#values from the 1976 US Standard Atmosphere Data https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf, Table 1: Geopotential Altitdue
	Tcheck = [288.150; 255.650; 216.650; 216.650; 216.650; 222.650; 228.650; 248.250; 270.650; 270.650; 270.650; 242.650; 214.650; 200.650; 187.650] #K
	Pcheck = [101325.0; 54019.0; 22632.0; 12044.0; 5474.8; 2153.0; 868.01; 318.22; 110.90; 86.162; 66.938; 17.660; 3.9564; 1.2501; 0.39814] #Pa

	#---Run Function/Tests
	T = zeros(length(h))
	P = zeros(length(h))
	for i=1:length(h)
		T, P = Atmosphere.temp_prestable(h[i])
		@test isapprox(T, Tcheck[i], atol=3.75e-3)
		@test isapprox(P, Pcheck[i], atol=1.155e1)
	end #for length h

end #Temp and Pres: Table

@testset "Ideal Gas: Density" begin

	#---Parameters, Inputs, etc.
	R = 8.31432e3 #N m kmol−1 K−1 gas constant used in standard atmosphere tables
	M = 28.9645 #g/mol mean molar mass for dry air
	Rs = R/M #Rspecific
	T = [288.150; 216.650; 216.650; 228.650; 270.650; 270.650; 214.650; 187.650] #K
	P = [101325.0; 22632.0; 5474.8; 868.01; 110.90; 66.938; 3.9564; .39814] #Pa

	#---Run Function/Tests
	rho = zeros(length(P))
	for i=1:length(P)
		rho = Atmosphere.density(T[i],P[i])
		@test isapprox(rho, P[i]/(Rs*T[i]), atol=1e-10)
	end #for length P

end #Ideal Gas Density

@testset "Ideal Gas: Speed of Sound" begin

	#---Parameters, Inputs, etc.
	gamma = 1.4  #ratio of specific heats (air)
	R = 8.31432e3 #N m kmol−1 K−1 gas constant used in standard atmosphere tables
	M = 28.9645 #g/mol mean molar mass for dry air
	Rs = R/M #Rspecific
	T = [288.150; 216.650; 216.650; 228.650; 270.650; 270.650; 214.650; 187.650] #K

	#---Initialize and Run Function
	sos = zeros(length(T))
	for i=1:length(T)
		sos = Atmosphere.speedofsound(T[i])
		@test isapprox(sos, sqrt(gamma*Rs*T[i]), atol=1e-10)
	end #for length T

end #Ideal Gas: SoS

@testset "Sutherland's Equation: Dynamic Viscosity" begin

	#---Parameters, Inputs, etc.
	Tsl = 288.15 #sea level temperature (K)
	musl = 0.0000181206 #sea level viscosity (N-s/m^2)
	Sc = 113.0 #constant in Sutherlands formula for air from Sutherland, W. (1893), "The viscosity of gases and molecular force"
	T = [288.150; 216.650; 216.650; 228.650; 270.650; 270.650; 214.650; 187.650] #K

	#---Initialize and Run Function
	for i=1:length(T)
		mu = Atmosphere.viscosity(T[i])
		@test isapprox(mu, musl*(T[i]/Tsl)^(3.0/2.0)*(Tsl+Sc)/(T[i]+Sc), atol=3.25e-8)
	end

end #Southerland's Eqn.: Viscosity
