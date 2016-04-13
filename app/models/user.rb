class User < ActiveRecord::Base
    validates :name, presence: true, length: {maximum: 30}
    validates :email, presence: true, length: {maximum: 30},
              format:{with: /\A[\w]+(\.|)[\w]+@[\w]+\.([a-z]+\.[a-z]+|[a-z]+)\Z/},
              uniqueness: true

    has_secure_password
end
