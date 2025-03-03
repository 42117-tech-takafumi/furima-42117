class ItemsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :edit]
  before_action :set_item, only: [:edit, :show ,:update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new()
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    binding.pry
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name,:info,:price,:image,:category_id,:sales_status_id,:shipping_fee_status_id,:scheduled_delivery_id,:prefecture_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless current_user == @item.user
      redirect_to action: :index
    end
  end

end
