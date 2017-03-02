class Group < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  validates :groupname, presence: true, uniqueness: true, case_sensitive: false
  before_validation :sanitize, :slugify


  def to_param
    self.slug
  end

  def slugify
    self.slug = self.groupname.downcase.gsub(" ", "-")
  end

  def sanitize
    self.groupname = self.groupname.strip
  end

  def set_admin(user)
    #user.groups << self
    Role.find_or_create_by(user_id: user.id, group_id: self.id, role_type: "admin")
  end

  def add(user)
    role=Role.find_or_create_by(user_id: user.id, group_id: self.id)
    role.update(role_type:"member")
  end

  def get_admin
    self.users.where("roles.role_type='admin'")
  end

  def get_members
    self.users.where("roles.role_type='member'")
  end

  def get_banned
    self.users.where("roles.role_type='banned'")
  end

  def deactivate
    self.update(active: false)
  end

  def activate
    self.update(active: true)
  end

  def leave(user)
    Role.find_by(user_id: user.id, group_id: self.id).destroy
  end

  def ban(user)
    role=Role.find_or_create_by(user_id: user.id, group_id: self.id)
    role.update(role_type:"banned")
  end

  def modify(args)
    if args[:role]=="admin"
      case args[:action]
      when "ban"
        self.ban(args[:other_user])
      when "add"
        self.add(args[:other_user])
      when "deactivate"
        self.deactivate
      when "activate"
        self.activate
      end
    else
      case args[:action]
      when "leave"
        self.leave(args[:user])
      when "join"
        self.add(args[:user])
      end
    end
  end

end
