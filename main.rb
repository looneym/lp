 require "lastpass.rb"
 require "pry"
 require "highline"

module System
  def self.pbcopy(input)
   str = input.to_s
   IO.popen('pbcopy', 'w') { |f| f << str }
   str
  end

  def self.pbpaste
   `pbpaste`
  end
end


class LP
  def initialize(username, password)
    @username = username
    @password = password
  end

  def vault
    @vault ||= LastPass::Vault.open_remote @username, @password
  end

  def find_all_by_name(input)
    matches = []
    vault.accounts.each do |account|
      matches << account if account.name.include? input
    end
    matches
  end
end

class Interface
  def initialize
    @cli = HighLine.new
    username = @cli.ask("Username?  ") 
    # username = @cli.ask("Username?  ") { |q| q.default = "" }
    # password = @cli.ask("Password?  ") { |q| q.default = "" }
    password = @cli.ask("Password?  ") 
    @lp = LP.new(username, password)
  end

  def search(input)
    accounts =  @lp.find_all_by_name(input)
    accounts.each_with_index do |account, index|
      puts "#{index} : #{account.name}"
    end
    result_index = @cli.ask("Enter index").to_i
    System.pbcopy(accounts[result_index].password)
    puts "Password copied to clipboard!"
  end
end

binding.pry
