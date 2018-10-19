class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :photo, PhotoUploader
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
  validates :username, presence: true, length: { minimum: 2 }, uniqueness: true

  def liked?(review)
    review.likes.find_by(user: self)
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:username] = "#{user_params[:first_name]} #{user_params[:last_name][0]}."
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def profile_picture
    if photo.present?
      ActionController::Base.helpers.cl_image_path photo
    elsif facebook_picture_url.present?
      facebook_picture_url
    else
      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAMFBMVEX29/fW1tbz9PTX19fr7Ozb29vk5OTw8fHT09Pq6ura2trm5ubg4ODh4eHy8/Pq6+sdZZ8pAAAEL0lEQVR4nO2b627CMAyFSW+5lfL+bzsKbJSqlCRmdh2dT9r+TEw+xLGdxD6dAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/0czNdIm/BeTH/rWGOOuP21/9pUJnWJws7QnzrWDlTbra3T9q7o/le1F2rSv0LXb+mrR2LxZvz+NYZI2kcZlV95dY5Q2ksK4v4APiaO0mcU0IUHfTJC2tJCmTRR4TZAqs2OGwCsaJWYJNK20ufn0WQKN6aUNzmVIiaJL3Fna5Dy6XIFXiZ200Vlk65uRNjqHc5HCQdrsdGy+j844PSkjN47+oibYFC6h0ZP3y3bhjJZjRrFALZVNQS78xek4Dpc7qRY3zSu5X1FRnTblTqpkIxK2oZKkHwkCdZTflEBjnIb705GiUEUwLS1K72g4X9AUaii+oXAfDV5KizQaFJKyhYpYSsv4Xtr8BC6kqk3Dy/dEUajjHoMiUMc7GyWYakiHp5MvF6jiaEE6Ajtp2xMpr2p0OCnhlK8iV9xI7VBYoyOSzhQuopI4c6NsEVVcJT4oeptRcuH9YCgQqOHgtCDfTzX56EyTrVBFzb0kcyvqSYVPss6JmhLFE58uUcVV9wbJiV/F3cUmNlGhShe986nL+7aAQVcUtZ2Py0GKjx18y0Q/xei7IwdVO/TuNjjixueyTLvL6PpnqdbcusKv/yEcdNYkvsxVLGKHfavRhcUO9C9/OF7siSsVrl/sLjtsTJU4c14s1XrHOnMsjXZrLublgt7G/uaB5vG7f/XE9Re0/o6k2bDPbIzDNLa7+OgvnV3ZPoXtf3CYOuBtvEwch9n+gsxxDlRvDZwntz7vJr83+XUIifsVtmvj3nZq4o6+dC/4Vz4/xLjxXVX2bjBx+WH51JjSxeZc79eXMJPvXVJlLqJqQfKLrzNhvNZkMz6OwSQfrYQn23JP8nfyPiPrp6W32zmIXlGR+hBTEb3hoDTLpiP4nMGyhKKLSGt/SkdsJ9K6LjIQe9EoeJwoRKo8ZRMoVdiUjzdlIxRr+JxUqoWBo575RWYOg89JheYwmNL9Q6HERuTchjL5gquguSNR1rAKlMiIbCXbHYHCjTXQiIQaUsN6AfzXirShg3z4qxreUCoRTHkuMJ7w1228gUagQZo0z1ykkLsyZTwcPhRyXwwzp0OBhJjR0vUlhdzv+oSxkUK4FXKXNPxFDe/pcIb7hFi/Qu6ylL8wpc0zl8D9Fly/wvq9tH6F9cfS+mua+ivv+k/ArC9PM/wNGdyhhv/hgvmQL9GsUP/LTP3vh6ylqUwLZv6YaDlCgwlsfirX2MZ04SY5nrgziFCHQBZHlR4RTpmhJOk7wPRTtz209B194RgDtPbcZvbfJ6lz7Vl+nOQP64cxfO/RtA3j4A8kDwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAcBx+AANTNQ0tf+asAAAAAElFTkSuQmCC"
    end
  end

end
