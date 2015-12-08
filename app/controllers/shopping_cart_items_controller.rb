class ShoppingCartItemsController < ApplicationController
    
    def create
        @user = User.find(params[:user_id])
        @shopping_cart_item = @user.shoppingCartItems.create(cart_item_params)
        @user.cartSize += params[:quantity].to_i
        @user.update(params.permit(:cartSize))
        redirect_to :back
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @shopping_cart_item = @user.shoppingCartItems.find(params[:id])
        @user.cartSize -= (@shopping_cart_item.quantity.to_i)
        @shopping_cart_item.destroy
        @user.update(params.permit(:cartSize))
        redirect_to user_cart_path
    end
    
    private
        def cart_item_params
            params.permit(:user_id, :product_id, :quantity)
        end
    
end
