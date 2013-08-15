Factory.define(:image, :class => Spree::Image) do |f|
  f.attachment_content_type 'image/jpg'
  f.attachment_file_name 'something_filename.jpg'
end

Factory.sequence(:custom_product_sequence) {|n| "Product ##{n} - #{rand(9999)}"}

Factory.define :one_of_many_producs, :class => Spree::Product do |f|
  f.name { Factory.next(:product_sequence) }
  f.description { Faker::Lorem.paragraphs(rand(5)+1).join("\n") }

  f.price 19.99
  f.cost_price 17.00
  f.sku "ABC"
end

Factory.define(:store, :class => Spree::Store) do |f|
  f.name 'My store'
  f.code 'my_store'
  f.domains 'www.example.com' # makes life simple, this is the default integration session domain
end
