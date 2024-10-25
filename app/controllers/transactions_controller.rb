class TransactionsController < ApplicationController
  def create
    # Create a new transaction (money transfer)
    transaction = Transaction.new(transaction_params)

    if transaction.save
      render json: { message: 'Transaction completed successfully', transaction: transaction }, status: :created
    else
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    # Retrieve all transactions (optional: add filters for wallets)
    transactions = Transaction.all
    render json: JSON.pretty_generate(transactions.as_json), status: :ok
  end

  private

  # Strong parameters to allow only safe input
  def transaction_params
    params.require(:transaction).permit(:amount, :source_wallet_id, :target_wallet_id)
  end
end
