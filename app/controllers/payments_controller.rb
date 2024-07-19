class PaymentsController < ApplicationController
  require 'pry'
  require 'date'

  protect_from_forgery except: :process_payment
  def index
    @payments = current_user.role == 'admin' ? Payment.all : current_user.payments
  end

  def new
    @payment = Payment.new
  end

  def create
      @payment = Payment.new(payment_params)
  end

  def transations
    @payments = current_user.role == 'admin' ? Payment.page(params[:page]).per(10) : current_user.payments.page(params[:page]).per(10)
  end

  def process_payment
    require 'mercadopago'
    sdk = Mercadopago::SDK.new(ENV.fetch('MERCADO_PAGO_ACCESS_TOKEN', nil))
    card_token = params[:cardToken]
    transaction_amount = params[:amount].to_f
    payment_method_id = 'visa'
    payer_email = params[:email]

    payment_data = {
      transaction_amount:,
      token: card_token,
      description: 'Descrição do pagamento',
      installments: 1,
      payment_method_id:,
      payer: {
        email: payer_email
      }
    }

    begin
      payment_response = sdk.payment.create(payment_data)
      # raise payment_response.inspect
      payment = payment_response[:response]

      data_string = payment["date_created"].to_time

      if payment['status'] == 'approved'
        # render json: { status: 'success', message: 'Pagamento aprovado!' }
        @new_payment = Payment.new(user_id: current_user.id, amount: payment_data[:transaction_amount], approved: true, created_at: data_string, updated_at: data_string )
        @new_payment.save
        redirect_to payments_success_path
      else
        # render json: { status: 'error', message: payment['status_detail'] }
        @new_payment = Payment.new(user_id: current_user.id, amount: payment_data[:transaction_amount], approved: false, created_at: data_string, updated_at: data_string)
        @new_payment.save
        redirect_to payments_fail_path
      end
    rescue StandardError => e
      logger.info e.inspect
      # render json: { status: 'error', message: e.message }
      redirect_to payments_fail_path
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:user_id, :amount,:approved)
  end

end
