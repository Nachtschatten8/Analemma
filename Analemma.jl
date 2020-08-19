using AstroLib, TimeZones

function analemma(start_date, end_date,
    latitude, longitude, elevation)
julian_dates = TimeZones.zdt2julian(start_date):TimeZones.zdt2julian(end_date)
right_ascension,declination=sunpos(julian_dates)
altaz=eq2hor.(right_ascension,declination,julian_dates,latitude,longitude,elevation)
altitude=getindex.(altaz,1)
azimuth=getindex.(altaz,2)
return azimuth,altitude
end

using Plots, Dates

azimuth, altitude = 
   analemma(ZonedDateTime(2020,1,1,12,tz"Europe/Brussels"),
            ZonedDateTime(2020,12,31,12,tz"Europe/Brussels"),
            ten(50,38),ten(5,34),150)

scatter(azimuth, altitude, aspect_ratio = :equal, 
    xlabel = "azimuth (°)", ylabel = "altitude (°)"
)
savefig("Lüttich.png")
   