class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create, :show, :update]

  def index
    @products = Product.all
    @parents = Category.where(ancestry: nil)
    @images = Image.all
  end

  def show
    @product = Product.find(params[:id])
    # @products = Product.where(user_id:params[:id])
    # @user = @product.user
    @category = @product.category
    # @image = @image.url
    # @brand = @product.brand
    @condition = @product.condition
    # @delivery_charge = @product.delivery_charge
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  require 'payjp'

  def purchase
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    Payjp::Charge.create(
      amount: @products.price, 
      card: params[:card_token],
      currency: 'jpy')
      @products.update(buyer_id: current_user.id)
      redirect_to root_path, notice: "支払いが完了しました"
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :description, :category_id, :brand_id, :condition_id, :delivery_charge_id, :prefecture, :day, :saler_id, :buyer_id, images_attributes: [:url, :_destroy, :id])
    # .marge(saler_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end


  # def purchase
  #   Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  #   charge = Payjp::Charge.create(
  #   amount: @product.price,
  #   card: params['card_token'],
  #   currency: 'jpy'
  #   )
  #   redirect_to action: :done
  # end

  def done
  end
end
