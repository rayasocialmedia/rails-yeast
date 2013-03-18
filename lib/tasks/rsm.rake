namespace :rsm do
  desc "Rename Application"
  task :rename, :name do |t, args|
    name = args.first
    if name.nil?
      puts 'New name can not be nil.'
    else
      old_name = "#{Rails.application.class.parent}"
      name_capitalized = name.downcase.gsub(/\s/, "_").camelize.capitalize
      gsub_file 'config/application.rb', /(module) (#{Regexp.escape(old_name)})/mi do |match|
        "module #{name_capitalized}"
      end
      
      gsub_file 'config/environment.rb', /(#{Regexp.escape(old_name)})(::Application.initialize!)/mi do |match|
        "#{name_capitalized}::Application.initialize!"
      end
      
      environments = ['development', 'production','test']
        for environment_name in environments
          gsub_file "config/environments/#{environment_name}.rb", /(#{Regexp.escape(old_name)})(::Application.configure)/mi do |match|
          "#{name_capitalized}::Application.configure"
        end
      end
      
      gsub_file 'config/routes.rb', /(#{Regexp.escape(old_name)})(::Application.routes)/mi do |match|
      "#{name_capitalized}::Application.routes"
      end
      
      gsub_file 'config.ru', /(run) (#{Regexp.escape(old_name)})(::Application)/mi do |match|
      "run #{name_capitalized}::Application"
      end
      
      gsub_file 'config/initializers/secret_token.rb', /(#{Regexp.escape(old_name)})(::Application.config.secret_token)/mi do |match|
      "#{name_capitalized}::Application.config.secret_token"
      end
      
      gsub_file 'config/initializers/session_store.rb', /(#{Regexp.escape(old_name)})(::Application.config.session_store)/mi do |match|
      "#{name_capitalized}::Application.config.session_store"
      end
      
      gsub_file 'Rakefile', /(#{Regexp.escape(old_name.capitalize)})(::Application.load_tasks)/mi do |match|
      "#{name_capitalized}::Application.load_tasks"
      end
    end
  end
end
