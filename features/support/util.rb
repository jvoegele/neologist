def extract_quips(table)
  table.raw.drop(1).map {|a| a.first}
end
