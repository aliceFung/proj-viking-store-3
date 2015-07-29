class AddressesController < ApplicationController

def new
  @address = Address.new( :user_id => params[:user_id])
  @states = State.all
end

def create
  @address = Address.new(whitelist_params)
  @address.city_id = find_city(params[:address][:city])
  @address.zip_code = params[:address][:zip_code].to_i
  @address.state_id = params[:address][:state_id].to_i
  @address.user_id = params[:address][:user_id]
  @address.street_address = params[:address][:street_address]
  if @address.save
    flash[:success] = "New Address Created"
    redirect_to @address
  else
    flash[:error] = @address.errors.full_messages.first
    @states = State.all
    @address
    render :new
  end
end

def index
  if User.exists?( params[:user_id])
    @addresses = Address.where( :user_id => params[:user_id])
    @user = User.find(params[:user_id])
  else
    @addresses = Address.all
  end
end

def show
	@address = Address.find(params[:id])
end

private

def whitelist_params
  params.permit(:address).permit(:street_address, :secondary_address, :city_id, :state_id, :zip_code, :user_id)
end

def find_city(cname)
  result = City.select(:id).where("name = ?", cname)
  if result.first
    result= result.first.id
  else
    c = City.new(name: cname)
    c.save
    c.id
  end
end


end
