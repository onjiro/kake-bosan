class Accounting::TransactionsController < ApplicationController
  # GET /accounting/transactions
  # GET /accounting/transactions.json
  def index
    @accounting_transactions = Accounting::Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounting_transactions }
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
    @accounting_transaction = Accounting::Transaction.new(params[:accounting_transaction])

    respond_to do |format|
      if @accounting_transaction.save
        format.html { redirect_to @accounting_transaction, notice: 'Transaction was successfully created.' }
        format.json { render json: @accounting_transaction, status: :created, location: @accounting_transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @accounting_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounting/transactions/1
  # PUT /accounting/transactions/1.json
  def update
    @accounting_transaction = Accounting::Transaction.find(params[:id])

    respond_to do |format|
      if @accounting_transaction.update_attributes(params[:accounting_transaction])
        format.html { redirect_to @accounting_transaction, notice: 'Transaction was successfully updated.' }
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
end
