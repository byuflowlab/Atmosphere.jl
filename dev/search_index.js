var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#Atmosphere-1",
    "page": "Home",
    "title": "Atmosphere",
    "category": "section",
    "text": "Summary: Functions concerning atmospheric conditions: air properites, velocities, etc.Authors: Judd Mehr & Taylor McDonnell"
},

{
    "location": "#Installation-1",
    "page": "Home",
    "title": "Installation",
    "category": "section",
    "text": "import Pkg\nPkg.add(\"https://github.com/byuflowlab/Atmosphere.jl\")"
},

{
    "location": "library/#",
    "page": "Library",
    "title": "Library",
    "category": "page",
    "text": ""
},

{
    "location": "library/#Atmosphere.atmospherefit-Tuple{Real}",
    "page": "Library",
    "title": "Atmosphere.atmospherefit",
    "category": "method",
    "text": "atmospherefit(altitude::Real)\n\nReturn density (kg/m^3), viscosity (Pa-s), and speed of sound (m/s) functions.\n\nInput altitude must be in meters.\n\n\n\n\n\n"
},

{
    "location": "library/#Atmosphere.atmospheretable-Tuple{Real}",
    "page": "Library",
    "title": "Atmosphere.atmospheretable",
    "category": "method",
    "text": "atmospheretable(altitude::Real)\n\nReturn density (kg/m^3), viscosity (Pa-s), and speed of sound (m/s) functions.\n\nInput altitude must be in meters.\n\n\n\n\n\n"
},

{
    "location": "library/#Atmosphere.gravity",
    "page": "Library",
    "title": "Atmosphere.gravity",
    "category": "function",
    "text": "gravity(altitude::Real)\n\nCalculate adjusted gravitational acceleration at altitude (meters) and latitude (degrees).\n\n1984 Ellipsoidal Gravity Formula.\n\n\n\n\n\n"
},

{
    "location": "library/#Public-API-1",
    "page": "Library",
    "title": "Public API",
    "category": "section",
    "text": "Modules = [Atmosphere]\nPrivate = false\nOrder = [:function, :type]"
},

{
    "location": "library/#Atmosphere.density-Tuple{Real,Real}",
    "page": "Library",
    "title": "Atmosphere.density",
    "category": "method",
    "text": "density(Temperature::Real, Pressure::Real)\n\nReturn Air Density (kg/m^3) from Ideal Gas Law.\n\nInput Temperature must be in Kelvin, and Input Pressure must be in Pascals.\n\n\n\n\n\n"
},

{
    "location": "library/#Atmosphere.speedofsound-Tuple{Real}",
    "page": "Library",
    "title": "Atmosphere.speedofsound",
    "category": "method",
    "text": "speedofsound(Temperature::Real)\n\nReturn Speed of Sound (m/s) from Ideal Gas Law.\n\nInput Temperature must be in Kelvin.\n\n\n\n\n\n"
},

{
    "location": "library/#Atmosphere.temp_presfit-Tuple{Real}",
    "page": "Library",
    "title": "Atmosphere.temp_presfit",
    "category": "method",
    "text": "temp_presfit(altitude::Real)\n\nCalculate atmospheric temperature and pressure for input altitude (meters) using fits of the standard atmosphere model, slightly modified from those found in Flight Vehicle Aerodynamics by Mark Drela.\n\n\n\n\n\n"
},

{
    "location": "library/#Atmosphere.temp_prestable-Tuple{Real}",
    "page": "Library",
    "title": "Atmosphere.temp_prestable",
    "category": "method",
    "text": "temp_prestable(altitude::Real)\n\nCalculate atmospheric temperature and pressure for input altitude (meters) from 1976 Standard Atmosphere Model.\n\n\n\n\n\n"
},

{
    "location": "library/#Atmosphere.viscosity-Tuple{Real}",
    "page": "Library",
    "title": "Atmosphere.viscosity",
    "category": "method",
    "text": "viscosity(Temperature::Real)\n\nReturn Dynamic Viscosity (Pa-s) from Sutherlands Equation.\n\nInput Temperature must be in Kelvin.\n\n\n\n\n\n"
},

{
    "location": "library/#Internal-API-1",
    "page": "Library",
    "title": "Internal API",
    "category": "section",
    "text": "Modules = [Atmosphere]\nPublic = false\nOrder = [:function, :type]"
},

]}
