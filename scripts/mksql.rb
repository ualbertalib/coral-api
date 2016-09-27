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


   puts "INSERT INTO `coral_api_prod`.`XloadLink` ( `coralName`, `SFXTag` )"
   puts "VALUES ( '#{fields[0]}', " "'#{fields[1]}'"  ");"
end
file.close


