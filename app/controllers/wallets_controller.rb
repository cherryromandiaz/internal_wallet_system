class WalletsController < ApplicationController
	
  def index
    wallets = Wallet.all

    render json: JSON.pretty_generate(
      wallets.map do |wallet|
        {
          id: wallet.id,
          owner_type: wallet.owner_type,
          owner_id: wallet.owner_id,
          balance: wallet.balance,  # Use updated balance from database
          created_at: wallet.created_at,
          updated_at: wallet.updated_at
        }
      end
    ), status: :ok
  end
  
  def create
    # Create a wallet for a specific entity (User, Team, etc.)
    # wallet = Wallet.new(wallet_params)
	# Dynamically find or create the owner based on owner_type and user name
	owner_class = params[:wallet][:owner_type].constantize
    owner = owner_class.find_or_create_by(name: wallet_params[:user][:name])

    # Create a new wallet with the specified owner and balance
    wallet = Wallet.new(balance: wallet_params[:balance], owner: owner)

    if wallet.save
      render json: { message: 'Wallet created successfully', wallet: wallet }, status: :created
    else
      render json: { errors: wallet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    # Retrieve wallet details by ID
    wallet = Wallet.find(params[:id])
    render json: wallet, status: :ok
  end

  def balance
    # Retrieve the current balance of a specific wallet
    wallet = Wallet.find(params[:id])
    render json: { balance: wallet.current_balance }, status: :ok
  end
	
  private

  # Strong parameters to allow only safe input
  def wallet_params
    params.require(:wallet).permit(:balance, :owner_type, user: [:name])
  end
  
end
