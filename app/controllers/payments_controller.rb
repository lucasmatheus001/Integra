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
      payment = payment_response[:response]
      data_string = payment["cause"][0]["data"]
      date_part = data_string.split(';').first

      datetime_object = DateTime.strptime(date_part, '%d-%m-%YT%H:%M:%S%Z')

      formatted_date = datetime_object.strftime('%Y-%m-%d %H:%M:%S.%N %z')


      if payment['status'] == 'approved'
        # render json: { status: 'success', message: 'Pagamento aprovado!' }
        @new_payment = Payment.new(user_id: current_user.id, amount: payment_data[:transaction_amount], approved: true, created_at: formatted_date, updated_at: formatted_date )
        @new_payment.save
        redirect_to payments_success_path
      else
        # render json: { status: 'error', message: payment['status_detail'] }
        @new_payment = Payment.new(user_id: current_user.id, amount: payment_data[:transaction_amount], approved: false, created_at: formatted_date, updated_at: formatted_date)
        @new_payment.save

        # binding.pry

        redirect_to payments_fail_path
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }
      redirect_to payments_fail_path
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:user_id, :amount,:approved)
  end

end
