require 'rails_helper'
describe 'User' do
    before(:each) do
        @user = User.new name: 'foo', email: 'foo@gmail.com', password: '1234', password_confirmation:'1234'
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

    it 'email with more than 30 character should not valid' do
        @user.name = ('a' * 31)+ '@gmail.com'
        expect(@user.valid?).to eq(false)
    end

    it 'email validation should not validate the invalid email' do
        valid_emails = ['xyz@abc@gmail.com','xyz@gmail.com.co.in','x_y12.z@gmail.co12.in','x_y12.z@gmail.com.i34n','x_y12.z@gmail.c_om.in']
        valid_emails.each do |email|
            @user.email = email
            expect(@user.valid?).to eq(false),"#{email.inspect} is a valid email"
        end
    end

    it 'email validation should validate the valid email' do
        valid_emails = ['xyz@gmail.com','x_y12.z@gmail.co.in']
        valid_emails.each do |email|
            @user.email = email
            expect(@user.valid?).to eq(true),"#{email.inspect} is an invalid email"
        end
    end

    it 'email should be uniq for each user' do
        duplicateUser = @user.dup
        @user.save
        expect(duplicateUser.valid?).to eq(false)
    end

end