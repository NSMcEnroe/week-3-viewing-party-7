class User <ApplicationRecord 
  validates_presence_of :email, :name, :password_digest, :password_confirmation
  validates_uniqueness_of :email
  validate :passwords_match
  
  has_many :viewing_parties
  has_secure_password

  def passwords_match
    errors.add(:password, "Please have the same password in both fields") if password != password_confirmation
  end
end 