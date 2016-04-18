require 'rails_helper'
describe 'User' do
  before(:each) do
    @user = User.new name: 'foo', email: 'foo@gmail.com', password: '123456', password_confirmation: '123456'
  end
  it 'should valid' do
    expect(@user.valid?).to eq(true)
  end

  it 'should not valid without a name' do
    @user.name = ''
    expect(@user.valid?).to eq(false)
  end

  it 'should not valid with name more than the 30 character' do
    @user.name = 'a' * 31
    expect(@user.valid?).to eq(false)
  end

  it 'should not valid without a email' do
    @user.email = ''
    expect(@user.valid?).to eq(false)
  end

  it 'email with up to 100 character should be valid' do
    @user.email = ('a' * 90)+ '@gmail.com'
    expect(@user.valid?).to eq(true), "email #{@user.email} hah #{@user.email.length} character"
  end

  it 'email with more than 100 character should not valid' do
    @user.email = ('a' * 91)+ '@gmail.com'
    expect(@user.valid?).to eq(false), "email #{@user.email} hah #{@user.email.length} character"
  end

  it 'email validation should not validate the invalid email' do
    valid_emails = %w(xyz@abc@gmail.com xyz@gmail.com.co.in x_y12.z@gmail.co12.in x_y12.z@gmail.com.i34n x_y12.z@gmail.c_om.in)
    valid_emails.each do |email|
      @user.email = email
      expect(@user.valid?).to eq(false), "#{email.inspect} is a valid email"
    end
  end

  it 'email validation should validate the valid email' do
    valid_emails = %w(xyz@gmail.com x_y12.z@gmail.co.in  negidharm.endra.negi44@gmail.co.in)
    valid_emails.each do |email|
      @user.email = email
      expect(@user.valid?).to eq(true), "#{email.inspect} is an invalid email"
    end
  end

  it 'email should be uniq for each user' do
    duplicate_user = @user.dup
    @user.save
    expect(duplicate_user.save).to eq(false)
  end

  it 'email validation should handle case-insensitive problem' do
    duplicate_user = @user.dup
    duplicate_user.email = duplicate_user.email.upcase
    @user.save
    expect(duplicate_user.valid?).to eq(false)
  end

  it 'password should not be empty' do
    @user.password = @user.password_confirmation = ''
    expect(@user.valid?).to eq(false)
  end

  it 'password should have at least 6 character' do
    @user.password = @user.password_confirmation = 'passw'
    expect(@user.valid?).to eq(false)
  end

end