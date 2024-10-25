class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transactions_as_source, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :transactions_as_target, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  # Method to calculate the current balance
  def current_balance
    initial_balance = self[:balance] # Access the database balance attribute directly
    incoming_total = transactions_as_target.sum(:amount) || 0
    outgoing_total = transactions_as_source.sum(:amount) || 0

    # Calculate the current balance
    initial_balance + incoming_total - outgoing_total
  end
end
