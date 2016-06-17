#!/usr/bin/env ruby

file=File.open("../data/sfx_coral_mapping.csv", "r")
file.each do |line|
    #split line into fields, trip empty lines
    fields=line.split(',').map{|field| field.strip}
    puts "INSERT INTO `coral_licensing_prod`.`XLink` ( `CoralName`, `SFXTarget`, `SFXPublicName`, `OURTitle`, `OURLink`) VALUES "
    puts "( '#{fields[0]}', " "'#{fields[1]}', " "'#{fields[2]}', " "'#{fields[3]}', " "'#{fields[4]}'"  ");"
end
file.close


