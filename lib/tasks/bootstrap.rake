namespace :authengine do
  desc 'create an admin access account, only when there are no accounts already configured. Call authengine:bootstrap[firstname,lastname,login,password] (no quotes)'
  task :bootstrap, [:firstname, :lastname, :login, :password] => :environment do |t, args|
    if args.to_hash.keys.length < 4
      puts "Please specify firstname, lastname, login and password"
    else
      if User.count > 0
        puts "There is already a user account present, you may only bootstrap the first account"
      else
        firstname = args[:firstname]
        lastname  = args[:lastname]
        login     = args[:login]
        password  = confirmation_password = args[:password]
        puts "Creating account for #{firstname} #{lastname} login: #{login}, password #{password}"
        user = User.new(:login => username, :password => password, :confirmation_password => confirmation_password)
        user.send('encrypt_password')
        user.send('make_activation_code')
        now = DateTime.now.to_formatted_s(:db)
        query = <<-SQL
        INSERT INTO users
            (activated_at, activation_code, created_at, crypted_password, email, enabled, firstName, lastName, login, password_reset_code, remember_token, remember_token_expires_at, salt, status, type, updated_at)
            VALUES
            ( #{now},#{user.activation_code},#{now}, #{user.crypted_password}, NULL, true, #{user.firstname}, #{user.lastname}, #{user.login}, NULL, NULL, NULL, #{user.salt}, NULL, NULL,#{now})
        SQL
        #can't use ActiveRecord#create here as it would trigger a notification email
        ActiveRecord::Base.connection.execute(query)
      end
    end
  end
end
