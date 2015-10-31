class Admin::ProductsController < AdminController

  def index
    @products = Product.with_category_names
  end


  def show
    @product = Product.with_category_names.find(params[:id])
    @stats = @product.order_stats
  end


  def new
    @product = Product.new
  end


  def create
    @product = Product.new(product_params)
    @product.sku = Faker::Code.ean
    if @product.save
      flash[:success] = "New Product created!"
      redirect_to admin_products_path
    else
      flash.now[:danger] = "Oops, something went wrong."
      render :new
    end
  end


  private


  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end


end
