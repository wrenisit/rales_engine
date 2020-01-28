require 'csv'

desc "Import Data"
task :import => [:environment] do

  customers = "db/data/customers.csv"
  merchants = "db/data/merchants.csv"
  items = "db/data/items.csv"
  invoices = "db/data/invoices.csv"
  invoice_items = "db/data/invoice_items.csv"
  transactions = "db/data/transactions.csv"


  CSV.foreach(customers, headers: true) do |row|
    Customer.create(row.to_hash)
  end

  CSV.foreach(merchants, headers: true) do |row|
    Merchant.create(row.to_hash)
  end

  CSV.foreach(items, headers: true) do |row|
    Item.create(row.to_hash)
  end

  CSV.foreach(invoices, headers: true) do |row|
    Invoice.create(row.to_hash)
  end

  CSV.foreach(invoice_items, headers: true) do |row|
    InvoiceItem.create(row.to_hash)
  end

  CSV.foreach(transactions, headers: true) do |row|
    Transaction.create(row.to_hash)
  end
end
# File.open("../../db/data/customers.csv") do |customer|
#   customer.read.each_line do |customer|
#     id, first_name, last_name, created_at, updated_at = customer.chomp.split(",")
#     # to create each record in the database
#     Customer.create!(:id => id, :first_name => first_name, :last_name => last_name, :created_at => created_at, :updated_at => updated_at)
#   end
# end
# desc "Import csv data into database record"
# task :csv_table_import, [:dir] => :environment do |task, args|
#   files = Dir.glob("#{args[:dir]}/*.csv")
#   files.each_with_index do |file, index|
#     model_name = file.split('/').last.split('.').first.camelize.singularize
#     firstline = 0
#     params_arr = []
#     keys = {}
#     begin
#       CSV.foreach(file) do |row|
#         keys = row if firstline == 0
#         params = {}
#         keys.each_with_index do |key, i|
#           if firstline > 0
#             params[key] = row[i]
#           else
#             break
#           end
#         end
#
#         firstline = 1 if firstline < 0
#         params_arr << params if firstline > 0
#       end
#     eval(model_name).create(params_arr)
#
#     rescue Exception => e
#       puts "#{e.message} : #{model_name}"
#     end
#   end
# end
