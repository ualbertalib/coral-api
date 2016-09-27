#!/usr/bin/env ruby

file=File.open("../data/sfx_tags.txt", "r")
file.each do |line|
    #split line into fields, trip empty lines
    fields=line.split("\t")
   puts "INSERT INTO `coral_api_prod`.`SFXTag` ( `SFXTag`) VALUES ( '#{fields[0]}' );"
end
file.close


