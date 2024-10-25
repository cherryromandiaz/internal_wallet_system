class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :valid_transaction
  validate :sufficient_balance, if: -> { source_wallet.present? }

  after_create :update_wallet_balances

  private

  # Ensure a valid transaction (either source or target wallet must be present)
  def valid_transaction
    if source_wallet.nil? && target_wallet.nil?
      errors.add(:base, "A valid transaction must specify either a source or target wallet.")
    elsif source_wallet && target_wallet.nil?
      errors.add(:base, "A valid transfer requires both source and target wallets.")
    end
  end

  # Ensure the source wallet has enough balance
  def sufficient_balance
    if source_wallet.balance < amount
      errors.add(:base, "Insufficient balance in the source wallet.")
    end
  end

  # Update the balances of the source and target wallets after a successful transaction
  def update_wallet_balances
    Wallet.transaction do
      source_wallet.update!(balance: source_wallet.balance - amount) if source_wallet
      target_wallet.update!(balance: target_wallet.balance + amount) if target_wallet
    end
  end
end
