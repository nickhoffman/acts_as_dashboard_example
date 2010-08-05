namespace :reminder do
  desc '[internal] Initialise the reminder array.'
  task :setup do
    set :reminders, Array.new
  end

  desc '[internal] Display the reminders.'
  task :show do
    unless reminders.empty?
      puts "\nReminder:"
      reminders.each do |reminder|
        puts "  * #{reminder}"
      end
    end
  end

  before  'deploy',        'reminder:setup'
  before  'deploy:setup',  'reminder:setup'

  after   'deploy',         'reminder:show'
  after   'deploy:setup',   'reminder:show'
end
