class PaymentsController < ApplicationController
  protect_from_forgery except: :process_payment
  def index
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
        redirect_to payments_sucess_path
      else
        # render json: { status: 'error', message: payment['status_detail'] }
        redirect_to payments_fail_path
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }
      redirect_to payments_fail_path
    end
  end

end
