# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string(255)
#  mobile_number   :string(255)      not null
#  status          :integer          default("created")
#  type            :integer
#  iters           :integer
#  salt            :string(255)
#  password_digest :string(255)
#  parent_id       :bigint
#  registration_no :string(255)
#  dob             :string(255)
#
# Indexes
#
#  index_users_on_mobile_number    (mobile_number) UNIQUE
#  index_users_on_parent_id        (parent_id)
#  index_users_on_registration_no  (registration_no)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => users.id)
#
class User < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :parent, class_name: 'User', optional: true
  has_many :children, class_name: 'User', foreign_key: 'parent_id', inverse_of: :parent,
                      dependent: :restrict_with_exception
  has_many :contents, dependent: :restrict_with_exception
  has_many :inventories, dependent: :restrict_with_exception
  has_many :sales, foreign_key: 'seller_id', inverse_of: :seller, dependent: :restrict_with_exception

  # relations with inventory transfers
  has_many :outbound_transfers, class_name: 'InventoryTransfer', foreign_key: 'sender_id', inverse_of: :sender,
                                dependent: :restrict_with_exception
  has_many :inbound_transfers, class_name: 'InventoryTransfer', foreign_key: 'receiver_id', inverse_of: :receiver,
                               dependent: :restrict_with_exception
  has_many :targets, dependent: :restrict_with_exception

  enum status: { created: 0, verified: 1, blocked: 2 }
  enum type: { admin: 0, area_development_officer: 1, master_distributor: 2, super_distributor: 3, distributor: 4 }

  def token
    Utils::Jwt.encode({ id:, mobile_number: })
  end

  def authenticate(password)
    password_digest.eql? ::Utils::Password.encrypt(password:, salt:)
  end

  def salt_password
    self.salt = SecureRandom.hex(8)
    self.iters = 1000
    self.password_digest = ::Utils::Password.encrypt(password: password_digest, salt:, iters:)
  end
end
