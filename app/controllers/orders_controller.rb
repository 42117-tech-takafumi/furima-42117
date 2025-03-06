class OrdersController < ApplicationController
  before_action :authenticate_user! , only: [:index]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root, only: [:index]
  
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_pay_form = OrderPayForm.new()
  end

  def create
    @order_pay_form = OrderPayForm.new(set_order)
    if @order_pay_form.valid?
      pay_item
      @order_pay_form.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_order
    params.require(:order_pay_form).permit(:postal_code,:prefecture_id,:city,:addresses,:building,:phone_number).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: @order_pay_form.token,
        currency: 'jpy'
      )
  end

  def move_to_root
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    end
  end

end
