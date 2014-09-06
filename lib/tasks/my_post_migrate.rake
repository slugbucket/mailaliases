namespace :db do
  desc "Create basic site users"
  task task_prep_sessions: :environment do
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
    puts "Loading user data from YAML"
    sessions = YAML::load_file("lib/tasks/post_migrate_users.yml")
    puts "Creating session users."
    sessions.each do |s|
      User.create(:id                  => s.id,
                     :username            => s.username,
                     :sign_in_count       => s.sign_in_count,
                     :current_sign_in_at  => s.current_sign_in_at,
                     :last_sign_in_at     => s.last_sign_in_at,
                     :current_sign_in_ip  => s.current_sign_in_ip,
                     :last_sign_in_ip     => s.last_sign_in_ip,
                     :remember_created_at => s.remember_created_at,
                     :created_at          => s.created_at,
                     :updated_at          => s.updated_at)
      puts "Created session user #{s.username}"
    end
  end

  desc "Create basic roles for managing site content"
  task task_prep_roles: :environment do
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
    puts "Loading user data from YAML"
    roles = YAML::load_file("lib/tasks/post_migrate_roles.yml")
    puts "Creating roles."
    roles.each do |r|
      Role.create(:id         => r.id,
                  :username   => r.name,
                  :created_at => r.created_at,
                  :updated_at => r.updated_at)
      puts "Created role: #{r.username}."
    end
  end

  desc "Create basic roles for managing site content"
  task task_populate_roles: :environment do
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
    puts "Loading user roles from YAML"
    puts "Except YAML parser doesn't recognise valid class defnition for UsersRoles - please configure manually."
#    uroles = YAML::load_file("lib/tasks/post_migrate_user_roles.yml")
#    uroles.each do |ur|
#      puts "Adding #{ur.user_id} to role #{ur.role_id}."
#      UsersRoles.create(:user_id => ur.user_id,
#                        :role_id => ur.role_id)
#    end
  end
end