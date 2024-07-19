class PaymentsController < ApplicationController
  protect_from_forgery except: :process_payment
  def index
    @payments = current_user.role == 'admin' ? Payment.all : current_user.payments
  end

  def transations
    @payments = current_user.role == 'admin' ? Payment.page(params[:page]).per(1) : current_user.payments.page(params[:page]).per(1)
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

      if payment['status'] == 'approved'
        # render json: { status: 'success', message: 'Pagamento aprovado!' }
        Payment.create(user_id: current_user.id, amount: transaction_amount, approved: true)
        redirect_to payments_sucess_path
      else
        # render json: { status: 'error', message: payment['status_detail'] }
        Payment.create(user_id: current_user.id, amount: transaction_amount, approved: false)
        redirect_to payments_fail_path
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }
      redirect_to payments_fail_path
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :email, :user_id)
  end

end
