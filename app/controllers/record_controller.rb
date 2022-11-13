class RecordController < ApplicationController
  def new
   @record = Record.new
   @pets = current_end_user.pets
   @foods = current_end_user.foods
  end
  
  def create
   @record = Record.new(record_params)
   @pets = current_end_user.pets
   @foods = current_end_user.foods
   @record.end_user_id = current_end_user.id
   if @record.save
    redirect_to record_index_path
   else
    render:new
   end
  end

  def index
   @records = Record.all
   # @records = Record.order(created_at: :desc)
   @records = current_end_user.records
  end

  def edit
   @record = Record.find(params[:id])
  end
  
  def update
   @record = Record.find(params[:id])
   if @record.update(record_params)
     redirect_to record_index_path
   else
    render:edit
   end
   
  end
  
  def destroy
   @record = Record.find(params[:id])
   @record.destroy
   redirect_to record_index_path
  end
  
  private
  
  def record_params
    params.require(:record).permit(:amount,:memo,:pet_id,:food_id)
    # ,:pet_name,:food_name
  end
  
end
