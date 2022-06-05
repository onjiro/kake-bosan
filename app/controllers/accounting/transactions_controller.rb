class Accounting::TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /accounting/transactions
  # GET /accounting/transactions.json
  def index
    from = params[:from] ? DateTime.parse(params[:from]) : nil
    to = params[:to] ? DateTime.parse(params[:to]) : nil

    if from.nil?
      @accounting_transactions = Accounting::Transaction
        .where(user_id: @current_user.id)
        .includes(entries: [:item])
        .joins(entries: [:item])
    else
      @accounting_transactions = Accounting::Transaction.find_by_terms(@current_user.id, from: from, to: to)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json do render json: @accounting_transactions, include: {
                              entries: { include: :item },
                            }       end
    end
  end

  # GET /accounting/transactions/1
  # GET /accounting/transactions/1.json
  def show
    @accounting_transaction = Accounting::Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accounting_transaction }
    end
  end

  # GET /accounting/transactions/new
  # GET /accounting/transactions/new.json
  def new
    @accounting_transaction = Accounting::Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accounting_transaction }
    end
  end

  # GET /accounting/transactions/1/edit
  def edit
    @accounting_transaction = Accounting::Transaction.find(params[:id])
  end

  # POST /accounting/transactions
  # POST /accounting/transactions.json
  def create
    @transaction = Accounting::Transaction.new(transaction_params)

    respond_to do |format|
      logger.debug(@transaction.inspect)
      logger.debug(@transaction.entries.inspect)
      if @transaction.save
        format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
        format.json { render json: @transaction.to_json(:include => :entries), status: :created, location: @transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounting/transactions/1
  # PUT /accounting/transactions/1.json
  def update
    @accounting_transaction = Accounting::Transaction.find(params[:id])

    respond_to do |format|
      if @accounting_transaction.update_attributes(params[:accounting_transaction])
        format.html { redirect_to @accounting_transaction, notice: "Transaction was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accounting_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounting/transactions/1
  # DELETE /accounting/transactions/1.json
  def destroy
    @accounting_transaction = Accounting::Transaction.find(params[:id])
    @accounting_transaction.destroy

    respond_to do |format|
      format.html { redirect_to accounting_transactions_url }
      format.json { head :no_content }
    end
  end

  private

  def transaction_params()
    return params
             .require(:transaction)
             .permit(:user_id, :date, entries_attributes: [:user_id, :side_id, :item_id, :amount])
             .tap do |params|
             params[:user_id] = @current_user.id
             params[:entries_attributes] = params[:entries_attributes].reject { |entry_params| entry_params[:amount].blank? }
             params[:entries_attributes].each { |entry| entry[:user_id] = @current_user.id }
           end
  end
end
