class Author < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "should match confirmation", if: :password


  def new_token
    SecureRandom.urlsafe_base64
  end
  # Rememember a author in the database for use in persistent sessions.
  def remember
    self.update_attribute(:remember_digest, new_token)
  end

  # Remembers a author in a persistent session.
  def remember(author)
    author.remember
    cookies.permanent[:remember_token] = author.remember_digest
    cookies.permament.signed[:author_id] = author.id
  end

end
