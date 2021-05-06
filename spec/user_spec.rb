require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  describe "Validations" do

    it "should be valid" do
      expect(@user.valid?).to be true
    end

    it "should not allow a blank name" do
      @user.name = "         "
      expect(@user.valid?).to be false
    end

    it "should not allow a blank email" do
      @user.email = "         "
      expect(@user.valid?).to be false
    end

    it "should not allow a name over 50 characters" do
      @user.name = "a" * 51
      expect(@user.valid?).to be false
    end

    it "should not allow an email over 255 characters" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user.valid?).to be false
    end

    it "should only accept valid email addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user.valid?).to be true
      end
    end

    it "should not accept invalid email addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user.valid?).to be_falsey, "#{invalid_address.inspect} should be invalid"
      end
    end

    it "should only allow unique email addresses" do 
      duplicate_user = @user.dup
      @user.save
      expect(duplicate_user.valid?).to be false
    end

    it "should save email addresses as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(mixed_case_email.downcase).to eq(@user.reload.email)
  end

  it "should not allow a blank password" do 
    @user.password = @user.password_confirmation = " " * 6
    expect(@user.valid?).to be false
  end

  it "should not allow a password under 6 characters" do 
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user.valid?).to be false
  end
  end
end