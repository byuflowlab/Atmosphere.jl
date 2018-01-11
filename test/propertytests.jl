@testset "Temperature and Pressure: Fit" begin

	#---Parameters, Inputs, etc.
	h = [0.0; 5.0; 11.0; 15.0; 20.0; 26.0; 32.0; 39.0; 47.0; 49.0; 51.0; 61.0; 71.0; 78.0; 84.5]*1e3

	#---Initialize and Run Function
	T = zeros(length(h))
	P = zeros(length(h))
	for i=1:length(h)
		T[i],P[i] = Atmosphere.temp_presfit(h[i])
	end #for length h

	#---Check Outputs
	#compared to values from the 1976 US Standard Atmosphere Data https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf, Table 1: Geopotential Altitdue, H
	Tcheck = [288.150; 255.650; 216.650; 216.650; 216.650; 222.650; 228.650; 248.250; 270.650; 270.650; 270.650; 242.650; 214.650; 200.650; 187.650] #K
	Pcheck = [101325.0; 54019.0; 22632.0; 12044.0; 5474.8; 2153.0; 868.01; 318.22; 110.90; 86.162; 66.938; 17.660; 3.9564; 1.2501; 0.39814] #Pa
	@test isapprox(T, Tcheck, atol=1e3)
	@test isapprox(P, Pcheck, atol=1e3)

end #Temp and Pres: Fit

@testset "Temperature and Pressure: Table" begin

	#---Parameters, Inputs, etc.
	h = [0.0; 5.0; 11.0; 15.0; 20.0; 26.0; 32.0; 39.0; 47.0; 49.0; 51.0; 61.0; 71.0; 78.0; 84.5]*1e3

	#---Initialize and Run Function
	T = zeros(length(h))
	P = zeros(length(h))
	for i=1:length(h)
		T[i],P[i] = Atmosphere.temp_prestable(h[i])
	end #for length h

	#---Check Outputs
	#compared to values from the 1976 US Standard Atmosphere Data https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf, Table 1: Geopotential Altitdue
	Tcheck = [288.150; 255.650; 216.650; 216.650; 216.650; 222.650; 228.650; 248.250; 270.650; 270.650; 270.650; 242.650; 214.650; 200.650; 187.650] #K
	Pcheck = [101325.0; 54019.0; 22632.0; 12044.0; 5474.8; 2153.0; 868.01; 318.22; 110.90; 86.162; 66.938; 17.660; 3.9564; 1.2501; 0.39814] #Pa
	@test isapprox(T, Tcheck, atol=1e1)
	@test isapprox(P, Pcheck, atol=1e3)

end #Temp and Pres: Table

@testset "Ideal Gas: Density" begin

	#---Parameters, Inputs, etc.
	R = 8.31432e3 #N m kmol−1 K−1 gas constant used in standard atmosphere tables
	M = 28.9645 #g/mol mean molar mass for dry air
	Rs = R/M #Rspecific
	T = [288.150; 216.650; 216.650; 228.650; 270.650; 270.650; 214.650; 187.650] #K
	P = [101325.0; 22632.0; 5474.8; 868.01; 110.90; 66.938; 3.9564; .39814] #Pa

	#---Initialize and Run Function
	rho = zeros(length(P))
	for i=1:length(P)
		rho[i] = Atmosphere.density(T[i],P[i])
	end #for length P

	#---Check Outputs
	@test isapprox(rho, P./(Rs.*T), atol=1e-4)

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
		sos[i] = Atmosphere.speedofsound(T[i])
	end #for length T

	#---Check Outputs
	@test isapprox(sos, sqrt.(gamma.*Rs.*T), atol=1e0)

end #Ideal Gas: SoS

@testset "Sutherland's Equation: Dynamic Viscosity" begin

	#---Parameters, Inputs, etc.
	Tref = 288.15 #sea level temperature (K)
	musl = 0.0000181206 #sea level viscosity (N-s/m^2)
	Sc = 113.0 #constant in Sutherlands formula for air from Sutherland, W. (1893), "The viscosity of gases and molecular force"
	T = [288.150; 216.650; 216.650; 228.650; 270.650; 270.650; 214.650; 187.650] #K

	#---Initialize and Run Function
	mu = zeros(length(T))
	for i=1:length(T)
		mu[i] = Atmosphere.viscosity(T[i])
	end

	#---Check Outputs
	@test isapprox(mu, musl.*(T./Tref).^(3.0./2.0).*(Tref+Sc)./(T+Sc), atol=1e-7)

end #Southerland's Eqn.: Viscosity
