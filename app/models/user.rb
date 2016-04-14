class User < ActiveRecord::Base
    has_many :blogs,  dependent: :destroy
    validates :name, presence: true, length: {maximum: 30}
    validates :email, presence: true, length: {maximum: 100},
              format:{with: /\A[\w]+(\.|)[\w]+@[\w]+\.([a-z]+\.[a-z]+|[a-z]+)\Z/},
              uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: true, length: {minimum: 6},confirmation: true
    validates :password_confirmation ,presence: true
end
