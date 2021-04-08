class AdminUser < ApplicationRecord
  # self.table_name = "admin_users"

  has_secure_password
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, through: :section_edits

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  FORBIDDEN_USERNAMES = %w(littlebopeep humptydumpty marymary)

  # Short validations
  validates :first_name,  presence: true,
                          length: { maximum: 25 }

  validates :last_name,   presence: true,
                          length: { maximum: 50 }

  validates :username,    presence: true,
                          length: { within: 8..25 },
                          uniqueness: true

  validates :email,       presence: true,
                          length: { maximum: 100 },
                          format: EMAIL_REGEX,
                          confirmation: true

  validate :username_is_allowed

  validate :no_new_users_on_sunday, on: :create

  scope :sorted, -> { order('last_name ASC, first_name ASC') }
  # Ex:- scope :active, lambda {where(:active => true)}

  def name
    "#{first_name} #{last_name}"
  end

  private

  # Custom validations
  def username_is_allowed
    errors.add(:username, 'has been restricted from use') if FORBIDDEN_USERNAMES.include?(username)
  end

  def no_new_users_on_sunday
    errors.add(:base, 'No new users on Sundays') if Time.now.wday == 0
  end
end
