#!/usr/bin/env ruby

file=File.open("../data/licdata.tsv", "r")
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


   puts "INSERT INTO `coral_licensing_prod`.`OURlicdata`"
   puts "           (`Active`, `Title`, `Vendor`, `Consortium`, `EReserves`, `CoursePack`, `DurableURL`, `AlumniAccess`,"
   puts "            `PerpetualAccess`, `Password`, `ILLPrint`, `ILLElectronic`, `ILLAriel`, `WalkIn`, `URL`, `TextMining`, `LocalLoading`)"
   puts "VALUES ('#{fields[0]}', " "'#{fields[1]}', " "'#{fields[2]}', " "'#{fields[3]}', " "'#{fields[4]}', " "'#{fields[5]}', "  "'#{fields[6]}', "
   puts "        '#{fields[7]}', " "'#{fields[8]}', " "'#{fields[9]}', " "'#{fields[10]}', " "'#{fields[11]}', " "'#{fields[12]}', " "'#{fields[13]}', "
   puts "        '#{fields[14]}', " "'#{fields[15]}', " "'#{fields[16]}'" ");"
   puts ""
end
file.close


