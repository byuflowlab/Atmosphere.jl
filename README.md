# Atmosphere

## Air Properties:
Calculates air density, dynamic viscosity, and speed of sound based on NASA's 1976 Standard Atmosphere Model.

Uses the Ideal Gas Law to calculate density and speed of sound.

Uses Sutherland's Equation to calculate viscosity.

Air Property Functions:
- atmospherefit
- temp_presfit
- atmospheretable
- temp_prestable
- density
- viscosity
- speedofsound

The function atmospherefit takes in an altitude (in meters) and outputs the density, viscosity, and speed of sound based on fits to the Standard Atmosphere Model (slightly modified from "Flight Vehicle Aerodynamics" by Dr. Mark Drela (MIT)).

The equations used for the fit are:

```julia
T = Tsl - 71.5 + 2*log(1+exp(35.75-3.25*(altkm))+exp(-3.0+0.0003*(altkm)^3))
P = Psl*exp(-0.118*(altkm)-(0.0015*(altkm)^2)/(1-0.018*(altkm)+0.0011*(altkm)^2))
```

and are found in the temp_presfit() function.

The atmospheretable, and temp_prestable() operate similarly, but use the actual, linearized, 1976 standard atmosphere tables (see NASA archive: https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf) rather than a single equation fit. 

The density(), viscosity(), and speedofsound() functions calculate their namesakes.
