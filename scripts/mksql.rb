#!/usr/bin/env ruby

file=File.open("../data/sfx_coral_mapping.tsv", "r")
file.each do |line|
    #split line into fields, trip empty lines
    fields=line.split("\t").map{|field| field.strip.gsub("'", %q(\\\'))}
    #fields=fields.map{ |field|
    #    if field.start_with?('"')
    #        field.gsub(%q(""), %q(") ).sub(/^"/, '').sub(/"$/,'')
    #    else
    #        field
    #    end
    #}


   puts "INSERT INTO `coral_licensing_prod`.`XloadLink` ( `coralName`, `SFXTarget`, `SFXPublicName`, `OURTitle`, `OURLink`)"
   puts "VALUES ( '#{fields[0]}', " "'#{fields[1]}', " "'#{fields[2]}', " "'#{fields[3]}', " "'#{fields[4]}'"  ");"
end
file.close


