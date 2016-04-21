require 'rails_helper'
describe 'Blog' do
 it 'should be valid' do
    blog = FactoryGirl.build(:blog)
    expect(blog.valid?).to eq(true)
 end
 it 'should not valid without title' do
    blog = FactoryGirl.build(:blog)
    blog.title = ''
    expect(blog.valid?).to eq(false)
 end
 it 'should not valid without content' do
    blog = FactoryGirl.build(:blog)
    blog.content = ''   
    expect(blog.valid?).to eq(false)
 end
end