@testset "Temperature and Pressure Fit: Drela" begin

	#---Parameters, Inputs, etc.
	h = [0.0 18300.0]

	#---Initialize and Run Function
	T = zeros(length(h))
	P = zeros(length(h))
	for i=1:length(h)
		T[i],P[i] = Atmosphere.temp_presfit(h[i])
	end #for length h

	#---Check Outputs
	#compared to values from the 1976 US Standard Atmosphere Data https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf, Table 1: Geopotential Altitdue
	Tcheck = [288.150; 216.650]
	Pcheck = [101325; 7158]
	@test isapprox(T, Tcheck, atol=1e0)
	@test isapprox(P, Pcheck, atol=1e2)

end #Temp and Pres: Drela

@testset "Temperature and Pressure Table: NASA" begin

	#---Parameters, Inputs, etc.
	h = [0.0 18300.0]

	#---Initialize and Run Function
	T = zeros(length(h))
	P = zeros(length(h))
	for i=1:length(h)
		T[i],P[i] = Atmosphere.temp_prestable(h[i])
	end #for length h

	#---Check Outputs
	#compared to values from the 1976 US Standard Atmosphere Data https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf, Table 1: Geopotential Altitdue
	Tcheck = [288.150; 216.650]
	Pcheck = [101325; 7158]
	@test isapprox(T, Tcheck, atol=1e-1)
	@test isapprox(P, Pcheck, atol=1e2)

end #Temp and Pres: NASA

@testset "Ideal Gas: Density" begin

	#---Parameters, Inputs, etc.
	R = 8.31432e3 #N m kmol−1 K−1 gas constant used in standard atmosphere tables
	M = 28.9645 #g/mol mean molar mass for dry air
	Rs = R/M #Rspecific
	P = [101325; 7158.08] #Pa, sea level, ~60k ft
	T = [288.150; 216.650] #K, sea level, ~60k ft

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
	T = [288.150; 216.650] #K, sea level, ~60k ft

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
	T = [288.150; 216.650] #K, sea level, ~60k ft

	#---Initialize and Run Function
	mu = zeros(length(T))
	for i=1:length(T)
		mu[i] = Atmosphere.viscosity(T[i])
	end

	#---Check Outputs
	@test isapprox(mu, musl.*(T./Tref).^(3.0./2.0).*(Tref+Sc)./(T+Sc), atol=1e-7)

end #Southerland's Eqn.: Viscosity
