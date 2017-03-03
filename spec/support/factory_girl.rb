RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    ensure
      DatabaseCleaner.clean
    end
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir[Rails.root.join('public/uploads/test')])
    end
  end
end
