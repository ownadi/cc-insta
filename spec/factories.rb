FactoryGirl.define do
  factory :image do
    file "data:image/jpeg;base64,#{Base64.encode64(File.read(Rails.root.join('spec/fixtures/lena.jpg')))}"
    trait :invalid do
      file 'xxx'
    end
    trait :with_faces do
      faces [[{"x"=>300, "y"=>177}, {"x"=>451, "y"=>177}, {"x"=>451, "y"=>329}, {"x"=>300, "y"=>329}]]
    end
  end
end
