require 'minitest/autorun'
require 'minitest/pride'
require_relative 'wizarding_bank'
require 'pry'

class WizardingBankTest < Minitest::Test

  def test_person_exists
    assert Person
  end

  def test_initializes_with_name_and_galleon_amount
    per = Person.new("Brenna", 1000)
    assert_equal "Brenna", per.name
    assert_equal 1000, per.galleons
  end

  def test_bank_exists
    assert Bank
  end

  def test_bank_initializes_with_name
    bank = Bank.new("PNC")
    assert_equal "PNC", bank.name
  end

  def test_person_can_open_account
    bank = Bank.new("PNC")
    person = Person.new("Aaron",100)
    bank.open_account(person)
    assert_equal 0, bank.accounts[person]
  end

  def test_accounts_variable_starts_empty
    bank = Bank.new("USBank")
    assert_equal({}, bank.accounts)
  end

  def test_person_can_deposit
    bank = Bank.new("First")
    person = Person.new("Batman", 200)
    bank.open_account(person)
    bank.deposit(person, 50)
    assert_equal 50, bank.accounts[person]
    assert_equal 150, person.galleons
  end

  def test_person_must_have_enough_galleons_to_deposit
    bank = Bank.new("First")
    person = Person.new("Batman", 200)
    bank.open_account(person)
    bank.deposit(person, 250)

    assert_equal 0, bank.accounts[person]
    assert_equal 200, person.galleons
  end

  def test_person_can_withdraw_from_bank
    bank = Bank.new("First")
    person = Person.new("Batman", 200)
    bank.open_account(person)
    bank.deposit(person, 200)
    bank.withdrawal(person,150)

    assert_equal 50, bank.accounts[person]
    assert_equal 150, person.galleons
  end

  def test_person_can_not_withdraw_without_funds
    bank = Bank.new("First")
    person = Person.new("Batman", 200)
    bank.open_account(person)
    bank.deposit(person, 200)
    bank.withdrawal(person,250)

    assert_equal 200, bank.accounts[person]
    assert_equal 0, person.galleons
  end

  def test_person_can_transfer
    bank1 = Bank.new("First")
    bank2 = Bank.new("Second")
    person = Person.new("Batman", 200)
    bank1.open_account(person)
    bank2.open_account(person)
    bank1.deposit(person,150)
    bank1.transfer(person,bank2,125)

    assert_equal 25, bank1.accounts[person]
    assert_equal 50, person.galleons
    assert_equal 125, bank2.accounts[person]
  end

  def test_person_can_not_transfer_without_funds
    bank1 = Bank.new("First")
    bank2 = Bank.new("Second")
    person = Person.new("Batman", 200)
    bank1.open_account(person)
    bank2.open_account(person)
    bank1.deposit(person,150)
    bank1.transfer(person,bank2,175)

    assert_equal 150, bank1.accounts[person]
    assert_equal 50, person.galleons
    assert_equal 0, bank2.accounts[person]
  end

  def test_person_cant_transfer_without_a_bank_account
    bank1 = Bank.new("First")
    bank2 = Bank.new("Second")
    person = Person.new("Batman", 200)
    bank1.open_account(person)
    bank1.deposit(person,150)
    bank1.transfer(person,bank2,175)

    assert_equal 150, bank1.accounts[person]
    assert_equal 50, person.galleons
    assert_equal nil, bank2.accounts[person]
  end

  def test_bank_account_total_is_calculated
    bank1 = Bank.new("First")
    person1 = Person.new("Batman", 200)
    person2 = Person.new("Superman", 400)
    bank1.open_account(person1)
    bank1.open_account(person2)
    bank1.deposit(person1,150)
    bank1.deposit(person2, 100)
    assert_equal 250, bank1.total_cash
  end

end
