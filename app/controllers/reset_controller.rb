class ResetController < ApplicationController
  def destroy
    # Wrap deletion in a transaction to ensure consistency
    ActiveRecord::Base.transaction do
      Transaction.delete_all  # Delete all transactions
      Wallet.delete_all       # Delete all wallets
      User.delete_all         # Optional: Delete all users
      Team.delete_all         # Optional: Delete all teams
      Stock.delete_all        # Optional: Delete all stocks
    end

    render json: { message: 'All data has been reset successfully.' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
