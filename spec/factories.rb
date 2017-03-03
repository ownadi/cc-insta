FactoryGirl.define do
  factory :image do
    file "data:image/jpeg;base64,#{Base64.encode64(File.read(Rails.root.join('spec/fixtures/lena.jpg')))}"
    trait :invalid do
      file 'xxx'
    end
  end
end
