require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'physical_currency_list.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Currency.new
  t.title = row['currency name']
  t.ticker = row['currency code']
  t.save
  puts "#{t.ticker}, #{t.title} saved"
end

puts "There are now #{Currency.count} rows in the currency table"