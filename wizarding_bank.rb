require 'pry'
class Person

  attr_reader :name
  attr_accessor :galleons

  def initialize(name, galleons=0)
    @name = name
    @galleons = galleons
    puts "#{name} has been created with #{galleons} galleons cash."
  end

end

class Bank

  attr_accessor :name, :accounts

  def initialize(name)
    @name = name
    "#{name.capitalize} has been created."
    @accounts = {}
  end

  def open_account(person)
    puts "An account has been created for #{person.name} with #{name}"
    accounts[person] = 0
  end

  def deposit(person, amount_of_galleons)
    if person.galleons < amount_of_galleons
      puts "#{person.name} does not have enough cash to perform this deposit"
    else
      person.galleons -= amount_of_galleons
      accounts[person] += amount_of_galleons
    end
  end

  def withdrawal(person, amount_of_galleons)
    if accounts[person] < amount_of_galleons
      puts "Insufficient Funds"
    else
      person.galleons += amount_of_galleons
      accounts[person] -= amount_of_galleons
      puts "#{person.name} has withdrawn #{amount_of_galleons} galleons.  Balance: #{person.galleons}."
    end
  end

  def transfer(person,target_bank,amount)
    if accounts[person] < amount
      puts "Insufficient Funds to transfer"
    elsif accounts[person] == nil || target_bank.accounts[person] == nil
      puts "#{person.name} does not have accounts at both banks."
    else
      accounts[person] -= amount
      target_bank.accounts[person] += amount

      puts "#{person.name} has transferred #{amount} galleons from #{name} to #{target_bank.name}."
    end
  end

  def total_cash
    total = accounts.values.reduce(:+)
    puts "Total Cash: #{total}"
    total
  end

end
