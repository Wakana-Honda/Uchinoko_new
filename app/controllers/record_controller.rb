class RecordController < ApplicationController
 before_action :set_record, only: [:edit, :update, :destroy]
 before_action :set_url, only: [:edit, :update, :destroy]
 
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
   @records = current_end_user.records
   @pet = current_end_user.pets
   @pet_id = Record.group(:pet_id).pluck(:pet_id).sort
  end
  
  def search
   @records = Record.where('pet_id LIKE ?', "%#{params[:pet_id]}%")
   @pet_id = Record.group(:pet_id).pluck(:pet_id).sort
   render :index
  # pet_name = params[:pet_id]
   # @records = Record.where('pet_name LIKE?', "%#{pet_name}%")
  end
  
  def calendar
   @records = Record.all
   @records = current_end_user.records.select("*, date(created_at)").group(:pet_id, "date(created_at)")
  end
  
  def show
   # binding.pry
   @record_pet = Record.where(pet_id: "8")
   #@pet = current_end_user.records.select("*, date(created_at)").group(:pet_id, "date(created_at)")
   #@pets = Pet.find(params[:id])
   #@record_pet = Record.where(pet_id: @pet)
  end

  def edit
   @record = Record.find(params[:id])
   @pets = current_end_user.pets
   @foods = current_end_user.foods
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
  #直叩き防止
  def set_record
      @record = Record.find(params[:id])
  end

  def set_url
    if @record.end_user_id != current_end_user.id
      redirect_to new_end_user_session_path
    end
  end
  
  def record_params
    params.require(:record).permit(:amount,:memo,:pet_id,:food_id,:start_time)
    # ,:pet_name,:food_name
  end
  
end
