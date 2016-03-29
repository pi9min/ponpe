namespace :user do
  desc 'Add permission of admin'
  task :grant, %w(email permission) => :environment do |_, args|
    logger = Logger.new(Rails.root.join('log', 'grant.log').to_s)
    permission = {}
    permissions = User.permissions.keys
    unless permissions.include?(args[:permission])
      puts "permission: #{args[:permission]} is not found."
      exit 1
    end
    user = User.find_by_email(args[:email])
    permission[:from] = user.permission
    user.permission = args[:permission].to_sym
    permission[:to] = user.permission
    user.save!
    puts "Changed permission of '#{args[:email]}'"
    puts "from: #{permission[:from]}"
    puts "to:   #{permission[:to]}"
    logger.info "email:#{args[:email]} from:#{permission[:from]} to:#{permission[:to]}"
  end

  desc 'List of permissions'
  task permissions: :environment do
    p User.permissions.keys
  end

  desc 'List of users'
  task list: :environment do
    require 'terminal-table'
    table = Terminal::Table.new do |t|
      t << %w(email permission)
      t << :separator
      User.all.each do |user|
        t << [user.email, user.permission]
      end
    end
    puts table
  end
end
