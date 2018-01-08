# Atmosphere

Calculates air density, dynamic viscosity, and speed of sound based on NASA's 1976 Standard Atmosphere Model.

Uses the Ideal Gas Law to calculate density and speed of sound.

Uses Sutherland's Equation to calculate viscosity.

Contains the Functions:
- atmospherefit
- temp_presdrela
- density
- viscosity
- speedofsound

The function atmospherefit takes in an altitude (in meters) and outputs the density, viscosity, and speed of sound based on fits to the Standard Atmosphere Model (slightly modified from "Flight Vehicle Aerodynamics" by Dr. Mark Drela (MIT)).

All other functions are auxiliary to the atmosphere function.
