# Atmosphere

Calculates air density, dynamic viscosity, and speed of sound based on NASA's 1976 Standard Atmosphere Model.

Can implement one of two fits to the NASA Temperature and Pressure tables.
1. Fits modified from "Flight Vehicle Aerodynamics" by Dr. Mark Drela (MIT)
2. Fits from NASA's website: https://www.grc.nasa.gov/www/k-12/airplane/atmosmet.html

Uses the Ideal Gas Law to calculate density and speed of sound.

Uses Sutherland's Equation to calculate viscosity.

Constains the Functions:
- atmosphere (main)
- temp_presdrela (default fit)
- tem_presnasa
- density
- viscosity
- speedofsound

The main function, atmosphere, takes in an altitude (in meters) and an optional argument to specify which fits to use and outputs the density, viscosity, and speed of sound. All other functions are auxiliary to this.
