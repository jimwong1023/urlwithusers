200.times do
  Url.create!(
  :original_url => Faker::Internet.url
  )
end