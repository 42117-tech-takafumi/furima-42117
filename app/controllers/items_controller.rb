class ItemsController < ApplicationController
  before_action :authenticate_user! , only: [:new]

  def index
    query = "SELECT * FROM items ORDER BY created_at ASC"
    @items = Item.find_by_sql(query)
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

  private

  def item_params
    params.require(:item).permit(:name,:info,:price,:image,:category_id,:sales_status_id,:shipping_fee_status_id,:scheduled_delivery_id,:prefecture_id).merge(user_id: current_user.id)
  end

end
