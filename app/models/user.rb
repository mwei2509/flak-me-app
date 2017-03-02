class User < ApplicationRecord
  has_many :messages
  has_many :roles, dependent: :destroy
  has_many :groups, through: :roles

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, email_format: { :message => 'must be a valid email' }
  has_secure_password

  def get_groups
    self.groups.where("roles.role_type='member' OR roles.role_type='admin'")
  end

  def get_admin_groups
    self.groups.where("roles.role_type='admin'")
  end

  def get_banned_groups
    self.groups.where("roles.role_type='banned'")
  end

  def not_in_groups
    Group.find(Group.ids-self.group_ids)
  end
end
